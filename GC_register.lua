--
-- GlobalCompany - AddOn - GC_AddOnDigitalFarming - register
--
-- @Interface: --
-- @Author: LS-Modcompany / kevink98
-- @Date: 21.08.2019
-- @Version: 1.0.0.0
--
-- @Support: LS-Modcompany
--
-- Changelog:
--
-- 	v1.0.0.0 (21.08.2019):
-- 		- initial Script Fs19 (kevink98)
--
-- Notes:
--
--
-- ToDo:
-- 
--
--

GC_register = {};
g_company.digitalFarming = {};

function GC_register:initGlobalCompany(customEnvironment, baseDirectory, xmlFile)
	if (g_company == nil) or (GC_register.isInitiated ~= nil) then
		return;
	end

	GC_register.debugIndex = g_company.debug:registerScriptName("GC_register");
	GC_register.modName = customEnvironment;
	GC_register.isInitiated = true;

	g_company.digitalFarming.displayPath = g_company.utils.createDirPath(customEnvironment) .. "display/display.i3d";

	GC_register:loadXml();

	g_company.addInit(GC_register, GC_register.init);
end

function GC_register:init()	
	
end

function GC_register:loadXml()
	local xmlPath = g_company.utils.createDirPath(GC_register.modName) .. "DigitalFarming.xml";

	if fileExists(xmlPath) then
		local xmlFile = loadXMLFile("digitalFarming", xmlPath);
		GC_register:loadVehiclesFromXml(xmlFile);
	end;
end;

function GC_register:loadVehiclesFromXml(xmlFile)
	g_company.digitalFarming.vehiclesData = {};
	local i = 0;
	while true do
		local xmlKey = string.format("digitalFarming.vehicles.vehicle(%d)", i);
		if not hasXMLProperty(xmlFile, xmlKey) then
			break;
		end;

		local vehicle = {};
		vehicle.xmlFilename = getXMLString(xmlFile, xmlKey .. "#xmlFilename");

		vehicle.displayPosition = {};
		local trans = g_company.utils.splitString(getXMLString(xmlFile, xmlKey .. ".displayPosition#trans"), " ");
		local rot = g_company.utils.splitString(getXMLString(xmlFile, xmlKey .. ".displayPosition#rot"), " ");
		vehicle.displayPosition.X = tonumber(trans[1]);
		vehicle.displayPosition.Y = tonumber(trans[2]);
		vehicle.displayPosition.Z = tonumber(trans[3]);
		vehicle.displayPosition.RX = tonumber(rot[1]);
		vehicle.displayPosition.RY = tonumber(rot[2]);
		vehicle.displayPosition.RZ = tonumber(rot[3]);

		vehicle.displayPosition.link = getXMLString(xmlFile, xmlKey .. ".displayPosition#link");
		table.insert(g_company.digitalFarming.vehiclesData, vehicle);
		i = i + 1;
	end;
end;

g_company.digitalFarming.getIsVehicleRegister = function(xmlFilename)
	if g_company.digitalFarming == nil or g_company.digitalFarming.vehiclesData == nil then 
		return false;
	end;

	for _,vehicle in pairs(g_company.digitalFarming.vehiclesData) do
		if vehicle.xmlFilename == xmlFilename then
			return true;
		end
	end;
	return false;
end;

g_company.digitalFarming.getVehicleDataByXmlfilename = function(xmlFilename)
	if g_company.digitalFarming == nil or g_company.digitalFarming.vehiclesData == nil then 
		return;
	end;

	for _,vehicle in pairs(g_company.digitalFarming.vehiclesData) do
		if vehicle.xmlFilename == xmlFilename then
			return vehicle;
		end
	end;
end;