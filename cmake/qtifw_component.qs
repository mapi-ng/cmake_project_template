function Component() {
    console.log("Component Initialized.");
    installer.installationFinished.connect(this, Component.prototype.installVCRedist);
}

Component.prototype.createOperations = function() {
    component.createOperations();
    if (systemInfo.productType === "windows") {
        // Create Start Menu shortcut
        component.addOperation("CreateShortcut",
            "@TargetDir@/bin/@Name@.exe",
            "@AllUsersStartMenuProgramsPath@/@Name@.lnk",
            "workingDirectory=@TargetDir@/bin/",
            "iconPath=@TargetDir@/bin/@Name@.exe", "iconId=0");
        console.log("Start menu shortcut created.");

        // Create common desktop shortcut
        // path \\Desktop points in fact to \\Public Desktop...
        var public_desktop = installer.environmentVariable("PUBLIC") + "\\Desktop";
        console.log("PUBLIC DESKTOP: " + public_desktop);
        component.addOperation("CreateShortcut",
            "@TargetDir@/bin/@Name@.exe",
            public_desktop + "/@Name@.lnk",
            "workingDirectory=@TargetDir@/bin/",
            "iconPath=@TargetDir@/bin/@Name@.exe", "iconId=0");
        console.log("Desktop shortcut created.");

        console.log("Creating config directory structure.");
        var working_dir = "C:\\ProgramData";
        // executeDetached will not delete folders on uninstall, unlike addOperation "Mkdir"
        installer.executeDetached("cmd", ["/C", "mkdir", "ProductDir"], working_dir);
        installer.executeDetached("cmd", ["/C", "mkdir", "ProductDir\\config"], working_dir);
        console.log("Config directory structure created.");
    }
}

Component.prototype.installVCRedist = function() {
    console.log("Checking for installation of VC++ Redistributables.");
    var registryVC2017x64 = installer.execute("reg",
        new Array("QUERY",
            "HKLM\\SOFTWARE\\Wow6432Node\\Microsoft\\VisualStudio\\14.0\\VC\\Runtimes\\x64",
            "/v", "Installed"))[0];

    var is_installed = false;

    console.log("VC++ Redistributables registry entry:");
    console.log(registryVC2017x64);

    if (registryVC2017x64 !== "") {
        // Get last (3rd) line of 'reg' command output - it contains value
        var key_value_line = registryVC2017x64.split(/\r?\n/)[2];

        // Get last element of the key-value line (hex number as string)
        var value = key_value_line.trim().split(/\s+/)[2];

        // Convert to decimal
        value = parseInt(value, 16);

        if (value === 1) {
            is_installed = true;
        }
    }

    if (is_installed === false) {
        console.log("VC++ Redistributables will be installed.");
        QMessageBox.information("Visual C++ Redistributables",
            "Install Visual C++ Redistributables",
            "The application requires Visual C++ 2017 Redistributables. Please follow the steps to install it now.",
            QMessageBox.OK);
        installer.execute("@TargetDir@/VC_redist.x64.exe", "/norestart", "/passive");
    } else {
        console.log("VC++ Redistributables are already installed.");
    }
}
