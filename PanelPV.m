%  Created on: 28/06/2023
%      Author: j-Lago
%
classdef PanelPV < handle
    properties
        Ns;
        Ms;
        bypass;
        blocking;
        
        Rs;
        Rp;
        Voc;
        Isc;
        a;
        n;
        k;
        q;
        EG;
        Tr;
       
        v;
        i;
        Tj;
        irrad;
        
        vt_;
        iph_;
        is_;
    end
    
    methods
        function self = PanelPV()
            self.bypass = 1;
            self.blocking = 1;
            self.Ns = 66;
            self.Ms = 1;
            self.Rs = 0.002;
            self.Rp = 2; %  7;
            self.Voc = 32.9/self.Ns;
            self.Isc = 8.21;
            self.a = 3.18e-3;
            self.n =  1.2;
            self.k = 1.38e-23;
            self.q = 1.60e-19;
            self.EG = 1.1;
            self.Tr = 273 + 25;
            
            self.Tj = 0;
            self.irrad = 0;
            self.vt_ = 0;
            self.iph_ = 0;
            self.is_ = 0;
            
            self.set_temp(25);
            self.set_irrad(800);
        end
        
        function set_irrad(self, irrad)
            self.irrad = irrad;
            self.iph_ = ( self.Isc + self.a*(self.Tj - self.Tr) ) * irrad / 1000;
        end
        
        function set_temp(self, Tjc)
            self.Tj = Tjc + 273;
            self.vt_ = self.n * self.k * self.Tj / self.q;
            
            self.is_ = ( ( self.Isc - self.Voc / self.Rp ) / ... 
                         ( exp( self.q * self.Voc / self.n / self.k / self.Tr)-1) ) * ...
                       ( self.Tj / self.Tr )^3 * exp( self.q * self.EG / self.n / self.k *( 1 / self.Tr -1 / self.Tj));
        end
        
        %metodo de Newton (calvula corrente para um vetor de tensões dado)
        function iter_i(self)
            
            self.i =   self.i - ...
                      ( self.iph_ - self.i - self.is_.*(exp((self.v/(self.Ns*self.Ms)+self.i.*self.Rs) ./ self.vt_)-1) - (self.v / (self.Ns*self.Ms) + self.i .* self.Rs) ./ self.Rp ) ./ ...
                      (-1-self.is_.*exp((self.v/(self.Ns*self.Ms)+self.i.*self.Rs) ./ self.vt_).*self.Rs./self.vt_-self.Rs ./ self.Rp);
            
        end
        
        function [ I, V ] = solve_i(self, irrad, Tjc, vpa)
           self.set_irrad(irrad);
           self.set_temp(Tjc);
           self.v = vpa;
           self.i = zeros(size(self.v));
           
           for k = 1:6
               self.iter_i();
           end
           
           if self.bypass
               self.v = max(self.v, 0);
           end
           if self.blocking
               for k = 1: length(self.i)
                   if self.i(k) <= 0
                       self.i(k) = 0;
                       self.v(k) = NaN;
                   end
               end
           end
           
           I = self.i;
           V = self.v;
           
           
        end
        
        
        %metodo de Newton (calvula tensao para um vetor de corretnes dado)
        function iter_v(self)
            
            self.v =   self.v - ...
                      ( self.iph_ - self.i - self.is_.*(exp((self.v/(self.Ns*self.Ms)+self.i.*self.Rs) ./ self.vt_)-1) - (self.v / (self.Ns*self.Ms) + self.i .* self.Rs) ./ self.Rp ) ./ ...
                      (-self.is_.*exp((self.v/(self.Ns*self.Ms)+self.i.*self.Rs) ./ self.vt_)./(self.Ns*self.Ms)./self.vt_-1./(self.Ns*self.Ms)./ self.Rp);
            
        end
        
        
        function [ I, V ] = solve_v(self, irrad, Tjc, ipa)
           self.set_irrad(irrad);
           self.set_temp(Tjc);
           self.i = ipa;
           self.v = ones(size(self.i)) * self.Voc *self.Ns *self.Ms;
           
           for k = 1:12
               self.iter_v();
           end
           
           if self.bypass
               self.v = max(self.v, 0);
           end
           if self.blocking
               for k = 1: length(self.i)
                   if self.i(k) <= 0
                       self.i(k) = 0;
                       self.v(k) = NaN;
                   end
               end
           end
           
           I = self.i;
           V = self.v;
           
           
        end
        
        
    end
end