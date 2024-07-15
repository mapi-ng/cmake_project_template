function Controller() {
    console.log("Controller initialized");
    if (systemInfo.productType === "windows") {
        installer.setDefaultPageVisible(QInstaller.StartMenuSelection, false);
    }
}
