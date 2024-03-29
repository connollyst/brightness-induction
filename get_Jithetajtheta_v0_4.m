function [J_exc_out,W_inh_out]=get_Jithetajtheta_v0_4(scale,K,orient,Delta,wave, zli)



multires=wave.multires;

    K=4;
        
    [J_exc,W_inh]=get_Jithetajtheta_v0_4_sub(scale,K,orient,Delta,wave, zli);
    
    
    pes_diag=0.5;
    
    if orient==2
        [J_diag,W_diag]=get_Jithetajtheta_v0_4_sub(scale,K,4,Delta,wave, zli);
        J_exc(:,:,[1 3])=(J_exc(:,:,[1 3])+J_diag(:,:,[1 3]))*pes_diag;
        W_inh(:,:,[1 3])=(W_inh(:,:,[1 3])+W_diag(:,:,[1 3]))*pes_diag;
        J_exc(:,:,2)=(J_exc(:,:,2)+J_diag(:,:,4))*pes_diag;
        W_inh(:,:,2)=(W_inh(:,:,2)+W_diag(:,:,4))*pes_diag;
    end
    
    if (orient==1 || orient==3)
        J_exc(:,:,2)=(J_exc(:,:,2)+J_exc(:,:,4))*pes_diag;
        W_inh(:,:,2)=(W_inh(:,:,2)+W_inh(:,:,4))*pes_diag;
    end
    
    
    J_exc_out=J_exc(:,:,1:3);
    W_inh_out=W_inh(:,:,1:3);



end

