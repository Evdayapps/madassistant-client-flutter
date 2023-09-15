#include "include/madassistant_flutter/madassistant_flutter_plugin_c_api.h"

#include <flutter/plugin_registrar_windows.h>

#include "madassistant_flutter_plugin.h"

void MadassistantFlutterPluginCApiRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  madassistant_flutter::MadassistantFlutterPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}
