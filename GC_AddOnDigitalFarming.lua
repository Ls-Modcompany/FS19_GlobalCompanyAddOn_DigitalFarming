--
-- GlobalCompany - AddOn - GC_AddOnDigitalFarming
--
-- @Interface: --
-- @Author: LS-Modcompany / kevink98
-- @Date: 
-- @Version: 1.0.0.0
--
-- @Support: LS-Modcompany
--
-- Changelog:
--
--
-- 	v1.0.0.0 ():
--
-- Notes:
--
--
-- ToDo:
-- 
--
--
--[[

for k,v in pairs(spec) do
    print(string.format("%s %s",k,v))
end;

]]--

GC_AddOnDigitalFarming = {}
GC_AddOnDigitalFarming.modName = g_currentModName;

function GC_AddOnDigitalFarming.initSpecialization()
    
end;

function GC_AddOnDigitalFarming.prerequisitesPresent(specializations)
    return SpecializationUtil.hasSpecialization(Drivable, specializations);
end;

function GC_AddOnDigitalFarming.registerFunctions(vehicleType)
	SpecializationUtil.registerFunction(vehicleType, "getSpec", GC_AddOnDigitalFarming.getSpec);
end;

function GC_AddOnDigitalFarming.registerEventListeners(vehicleType)
	SpecializationUtil.registerEventListener(vehicleType, "onLoad", GC_AddOnDigitalFarming);
    SpecializationUtil.registerEventListener(vehicleType, "onUpdate", GC_AddOnDigitalFarming);
	SpecializationUtil.registerEventListener(vehicleType, "onDraw", GC_AddOnDigitalFarming);
end;

function GC_AddOnDigitalFarming:getSpec()
    return self["spec_FS19_GlobalCompany.gcAddOnDigitalFarming"];
end

function GC_AddOnDigitalFarming:onLoad(savegame)
    local spec = self:getSpec();    
    spec.isEnabled = g_company.digitalFarming.getIsVehicleRegister(self.configFileName);
    

    if spec.isEnabled then
        spec.vehicleData = g_company.digitalFarming.getVehicleDataByXmlfilename(self.configFileName);

        --load display
        local parentNode = I3DUtil.indexToObject(self.components, spec.vehicleData.displayPosition.link);
        
        local nodeId = I3DUtil.indexToObject(g_i3DManager:loadSharedI3DFile(g_company.digitalFarming.displayPath, "", false, false, false), "0");
        
        link(parentNode, nodeId);
        
        setTranslation(nodeId, spec.vehicleData.displayPosition.X, spec.vehicleData.displayPosition.Y, spec.vehicleData.displayPosition.Z);
        setRotation(nodeId, math.rad(spec.vehicleData.displayPosition.RX), math.rad(spec.vehicleData.displayPosition.RY), math.rad(spec.vehicleData.displayPosition.RZ));
        
        
    end;


end;

function GC_AddOnDigitalFarming:onUpdate()   
    local spec = self:getSpec();
    
    
    

end;

function GC_AddOnDigitalFarming:onDraw()
    local spec = self:getSpec();

    
    
end;
