function [Left_HS,Right_HS]=split_HS(FC)
    Left_HS=FC(1:180,1:180,:);
    Right_HS=FC(181:360,181:360,:);
end
