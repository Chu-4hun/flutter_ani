//
//  Generated file. Do not edit.
//

// clang-format off

#include "generated_plugin_registrant.h"

#include <dart_vlc/dart_vlc_plugin.h>
#include <flutter_meedu_videoplayer/flutter_meedu_videoplayer_plugin.h>
#include <screen_retriever/screen_retriever_plugin.h>
#include <system_theme/system_theme_plugin.h>
#include <window_manager/window_manager_plugin.h>

void fl_register_plugins(FlPluginRegistry* registry) {
  g_autoptr(FlPluginRegistrar) dart_vlc_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "DartVlcPlugin");
  dart_vlc_plugin_register_with_registrar(dart_vlc_registrar);
  g_autoptr(FlPluginRegistrar) flutter_meedu_videoplayer_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "FlutterMeeduVideoplayerPlugin");
  flutter_meedu_videoplayer_plugin_register_with_registrar(flutter_meedu_videoplayer_registrar);
  g_autoptr(FlPluginRegistrar) screen_retriever_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "ScreenRetrieverPlugin");
  screen_retriever_plugin_register_with_registrar(screen_retriever_registrar);
  g_autoptr(FlPluginRegistrar) system_theme_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "SystemThemePlugin");
  system_theme_plugin_register_with_registrar(system_theme_registrar);
  g_autoptr(FlPluginRegistrar) window_manager_registrar =
      fl_plugin_registry_get_registrar_for_plugin(registry, "WindowManagerPlugin");
  window_manager_plugin_register_with_registrar(window_manager_registrar);
}
