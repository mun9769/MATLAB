classdef spmsm_1 < handle

    properties

        % material properties
        core_material = "Cogent Power - M330-35A, B-H at 50Hz"; % fixed-independent
        winding_material = "copper"; % fixed
        magnet_material = "arnold_Magnetics_N38UH_80C"; % fixed
        rhom_core = 7650; % mass density of core material [kg/m3] % fixed
        rhom_winding = 8933; % mass density of winding material [kg/m3] % fixed
        rhom_magnet = 7500; % mass density of winding material [kg/m3] % fixed
        sigma_sw_20C = 58e6; % conductivity of winding material [S/m] % fixed
        alpha_t_sw = 0.00381; % terperature coefficient stator winding resistance [1/K] % fixed
        ki = 0.95; % iron insulation factor % fixed

        % temperature assumptions
        Tamb = 40; % ambient temperature [C] % fixed
        Tr_sw = 60; % temperature rise of the stator winding [C] % fixed

        % discritization parameter
        roundingFlag = false;

        % ratings
        Pout = 0.6; % rated output power [kW] % fixed
        Vdc = 240; % voltage of the DC link
        Vdrop = 4; % voltage drop of inverter elements
        BaseRPM = 4500; % the motor base speed [rpm] % fixed
        dEff = 92; % desired efficiency [%] % fixed
        dPF = 0.95; % desired power factor % fixed

        % important geometrical parameters
        p = 4; %number of poles % independent
        Ns = 24; % number of stator slots % independent
        g = 0.8; % minimum air gap length [mm] % indepe
        ar = 1.5; % aspect ratio: ar = Lstk/tau_p



        % sizing parameters
        Bav = 0.6; % magnetic loading [Tesla] % indep
        ac = 16; % electric loading [kA/m] % indep
        Jsw = 8; % current density assumption in stator winding [A/mm2] % indp
        g_emf = 0.97; % g_emf = Eph/Vph % indep

        phi_tot; % total air gap flux [mWb] %indirect-dependent-noneditable
        phi_st; % maximum flux in stator tooth [mWb] % ..
        phi_p; % pole flux [mWb] %..

        Bst = 1.1; % maximum flux density in stator tooth [Tesla] % indep
        Bsy = 0.8; % maximum flux density in stator yoke [Tesla] %..
        Brt = 1.1; % maximum flux density in rotor tooth [Tesla] % ..
        Bry = 1; % maxinum flux density in rotor yoke [Tesla] %..


        %stator dimensions
        ISD = 50; % inner stator diameter [mm] % indirect-dependent-editable
        OSD = 75; % outer stator diameter [mm] %..
        wst = 3; % width of stator tooth [mm] %..
        stta = 20; % tooth tip angle [deg] %indep
        bs0 = 2; % slot openning [mm] %..
        hs0 = 0.8; % slot openning height [mm]
        dss = 10; % depth of the stator slot [mm]
        Lstk = 60; % stack length [mm]
        slArea; % area of stator lamination [mm2]
        KgStator; % mass of stator core [Kg]
        ssArea; % stator slot area [mm2]
        caArea; % coil arm area [mm2]


        % two arrays to store x and y coordinates of vertices of stator
        % slot
        x_spts;
        y_spts;
        pc; % coil arm polygon

        % winding parameters
        connection = 'star'; % type: 'star', 'delta'
        Np = 1; % number of parallel branches [-]
        Ntc = 85; % number of turns per ciol [-]
        Ntph; % number of turns per phase
        kfill = 0.3; % copper fill factore
        ssq = 0; % stator slot skew
        wireDMax = 1.8; % maximum wire diameter that can be used for winding [mm]
        wireD; % diameter of wires [mm], [1xN]
        Nstrands = 1; % number of parallel strands[-]
        paperT = 0.6; % slot paper thickness [mm]
        Lend = 2; % end length of conductor before bending [mm]
        bw0 = 3; % the distance between two coil arms [mm]
        kw; % winding factor

        % three arrays that store winding information
        phaseA;
        phaseB;
        phaseC;

        % rotor dimensions
        Dsh = 50; % shaft diameter [mm]
        wm1 = 22; %width of magnet 1 [mm]
        dm1 = 8; % depth of magnet 1 [mm]
        dm2 = 8; % depth of magnet 2 [mm]

        rtta = 20; % rotor tooth tip angle [deg]
        br0 = 4; % rotor slot openning [mm]
        hr0 = 2; % rotor slot opennning height [mm]
        wrib = 1; % width of rotor lamination rib [mm]
        rlArea; % area of rotor lamination [mm2]
        KgRotor; % mass of rotor core [Kg]
        mArea; % total areea of all magnets [mm2]
        KgMagnets; % mass of magnets [Kg]

        % vectices of stator slot
        x_rpts;
        y_rpts;

        % error between inital assumptions and calculated values
        Ntph_err;
        Jsw_err;

    end

    properties (Dependent=true)

        % dependent geometrical variables
        alpha_s; % stator slot pitch angle: 2*pi/Ns;
        alpha_p; % pole pitch angle: 2*pi/p;
        gamma_so; % stator slot openning angle; 2*asin(bs0/ISD)
        wsy; % width of stator yoke[mm]
        wry; % width of rotor yoke [mm]
        splitRatio; % split ratio, splitRatio = ISD/OSD
        stwRatio; % stator tooth width ratio, stwRatio = Ns*wst/(pi*ISD)

        % motor param
        Tout; % rated output torque [Nm]
        BaseRPS;
        BaseOmega_m; % rated angular speed

        Pin; % rated input power [kW]
        Qin; % rated dinput reactive power [kW]
        Sin; % rated input volt-ampere [kW]

        fs; % supply freq
        Vt;% line-to-line terminal voltage
        It; % line terminal current [A]
        Vph; % phase voltage
        Iph;
        Vc; % coil voltage
        Ic; % coil current

        cAws; % copper area of wires [mm2]
        cAsc; % copper area of single conductor [mm2]
        cAca; % cooper area of coil arm [mm2]
        gAca; % gross area of coil arm [mm2]

        Ncpph; % number of coils per each phase
        Lew; % end winding length of a coil [mm]
        Lmt; % mean turn length of the coil [mm]
        KgWinding; % mass of winding [Kg]
        KgActiveParts; % total mass of active parts [kg]

        G; % output coefficient
        D2L; % D2L product
        tau_p; % pole pitch

        Eph; % phase back-EMF
        Ts; % fundamental time period [ms]

        Rph_slot; % in slot phase resistance [Ohm]
        pcu_slot; % slot winding copper losses [W]
        Rph_ew; % end winding phase resistance [Ohm]
        pcu_ew; % end winding copper lossed [W]
        Rph; % phase resistance [Ohm]
        pcu; % total stator winding copper losses [W]

        % winding material dependent properties
        rho_sw_20C; % resistivity of winding material at 20C [Ohm]
        rho_sw_wt; % resistivity of winding material at working temperature [Ohm]
        sigma_sw_wt; % conductivity of winding material at working termperature [S/m]
    end

    methods
        function set.Ns(obj, newNs)
            if rem(newNs,3)
                error('Ns should be an integer multiplier of 3.')
            else
                obj.Ns = newNs;
            end
        end
        function set.connection(obj, aa)
            if strcmpi(aa, 'star')
                obj.connection = aa;
            elseif strcmpi(aa, 'delta')
                obj.connection = aa;
            else
                error('stator winding connection must be "star" or "delta"');

            end
        end

        function y=get.BaseRPS(obj)
            y=obj.BaseRPM/60;
        end

        function y = get.BaseOmega_m(obj)
            y = 2*pi*obj.BaseRPS;
        end

        function y=get.fs(obj)
            y=obj.BaseRPM * obj.p / 120;
        end

        function y=get.Tout(obj)
            y= obj.Pout * 1000 / obj.BaseOmega_m;
        end

        function y=get.Vph(obj)
            if strcmpi(obj.connection, 'star')
                y=obj.Vt/sqrt(3);
            elseif strcmpi(obj.connection, 'delta')
                y=obj.Vt;
            end
        end
        function y=get.Vt(obj)
            y=(obj.Vdc - obj.Vdrop)*0.7071;
        end


        function y = get.tau_p(obj)
            y=pi*obj.ISD/obj.p;
        end

        function y=get.alpha_s(obj)
            y=2*pi/obj.Ns;
        end
        function y=get.alpha_p(obj)
            y=2*pi/obj.p;
        end
        function y=get.gamma_so(obj)
            y=2*asin(obj.bs0/obj.ISD);
        end
        function y=get.wsy(obj)
            y=obj.OSD/2 - obj.ISD/2 - obj.dss;
        end


        % *******************************************************
        function updateStatorModel(obj)
            x1=(obj.ISD/2) * cos(obj.gamma_so/2);
            y1=(obj.ISD/2) * sin(obj.gamma_so/2);

            u = [x1, y1];
            u = u/norm(u);

            x2 = x1 + obj.hs0 * u(1);
            y2 = y1 + obj.hs0 * u(2);

            [ux, uy] = rotate_pts(u(1), u(2), pi/2-obj.stta*pi/180);
            u1 = [ux, uy];

            u2 = [cos(obj.alpha_s/2), sin(obj.alpha_s/2)];

        end



        function updateModel(obj)
            obj.updateStatorModel;
            obj.updateRotorModel;
            obj.updateWindingPattern;
        end


    end

    methods
        function plotSketch(obj)
            hold on;
            axis off equal;


            x1=(obj.ISD/2) * cos(obj.gamma_so/2);
            y1=(obj.ISD/2) * sin(obj.gamma_so/2);

            u = [x1, y1];
            u = u/norm(u);

            x2 = x1 + obj.hs0 * u(1);
            y2 = y1 + obj.hs0 * u(2);

            [ux, uy] = rotate_pts(u(1), u(2), pi/2-obj.stta*pi/180);
            u1 = [ux, uy];

            u2 = [cos(obj.alpha_s/2), sin(obj.alpha_s/2)];

            [x3, y3] = getLineLineIntersection([0, -obj.wst*0.5/cos(obj.alpha_s/2)], u2, [x2,y2],u1);
            
            tmp_angle = 2*asin(obj.wst/(obj.ISD+2*obj.dss));

            [x4, y4] = rotate_pts(obj.ISD/2 + obj.dss, 0, obj.alpha_s/2-tmp_angle/2);

            obj.x_spts = [x1 x2 x3 x4];
            obj.y_spts = [y1 y2 y3 y4];

            

            t = linspace(0, atan2(y4,x4) ,20);
            x=(obj.ISD/2 + obj.dss) * cos(t);
            y=(obj.ISD/2 + obj.dss) * sin(t);
            x=[x,x3,x2];
            y=[y,y3,y2];

            t = linspace(atan2(y1,x1), 0, 10);
            x= [x, (obj.ISD/2) * cos(t)];
            y= [y, (obj.ISD/2) * sin(t)];
            obj.ssArea = 2*polyarea(x,y);

            % ******************
            % calculation of the stator lamination area and mass
            obj.slArea = pi*obj.OSD^2/4 - pi*obj.ISD^2/4 - obj.Ns * obj.ssArea;
            obj.KgStator = 1e-9 * obj.Lstk * obj.slArea * obj.rhom_core;

            plot(obj.x_spts, obj.y_spts, 'r','linewidth',1.4);
            plot(x,y, 'b');
        end
    end
end