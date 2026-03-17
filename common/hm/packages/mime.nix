{ lib, ... }:
{
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "zen-beta.desktop";
      "x-scheme-handler/https" = "zen-beta.desktop";
      "x-scheme-handler/chrome" = "zen-beta.desktop";
      "text/html" = "zen-beta.desktop";
      "application/x-extension-htm" = "zen-beta.desktop";
      "application/x-extension-html" = "zen-beta.desktop";
      "application/x-extension-shtml" = "zen-beta.desktop";
      "application/xhtml+xml" = "zen-beta.desktop";
      "application/x-extension-xhtml" = "zen-beta.desktop";
      "application/x-extension-xht" = "zen-beta.desktop";

      "image/jpeg" = [ "image-roll.desktop" ];
      "image/jpg" = [ "image-roll.desktop" ];
      "image/png" = [ "image-roll.desktop" ];
      "image/gif" = [ "image-roll.desktop" ];
      "image/bmp" = [ "image-roll.desktop" ];
      "image/tiff" = [ "image-roll.desktop" ];
      "image/x-bmp" = [ "image-roll.desktop" ];
      "image/x-ico" = [ "image-roll.desktop" ];
      "image/x-png" = [ "image-roll.desktop" ];
      "image/x-tga" = [ "image-roll.desktop" ];
      "image/x-tiff" = [ "image-roll.desktop" ];
      "image/x-webp" = [ "image-roll.desktop" ];
      "image/webp" = [ "image-roll.desktop" ];
      "image/svg+xml" = [ "image-roll.desktop" ];
      
      "application/javascript" = "code.desktop";
      "application/json" = "code.desktop";
      "application/x-shellscript" = "code.desktop";
      "application/xml" = "code.desktop";
      "inode/directory" = "org.kde.dolphin.desktop";
      "text/css" = "code.desktop";
      "text/markdown" = "code.desktop";
      "text/plain" = "code.desktop";
      "text/x-c++src" = "code.desktop";
      "text/x-csrc" = "code.desktop";
      "text/x-go" = "code.desktop";
      "text/x-java-source" = "code.desktop";
      "text/x-python" = "code.desktop";
      "text/x-typescript" = "code.desktop";
      "x-scheme-handler/about" = "org.kde.dolphin.desktop";
      "x-scheme-handler/file" = "org.kde.dolphin.desktop";

      "video/mp4" = "mpc-qt.desktop";
      "video/x-matroska" = "mpc-qt.desktop";
      "video/webm" = "mpc-qt.desktop";
      "video/avi" = "mpc-qt.desktop";
      "video/x-msvideo" = "mpc-qt.desktop";
      "video/quicktime" = "mpc-qt.desktop";
      "video/mpeg" = "mpc-qt.desktop";
      "video/x-mpeg" = "mpc-qt.desktop";
      "video/mp2t" = "mpc-qt.desktop";
      "video/3gpp" = "mpc-qt.desktop";
      "video/3gpp2" = "mpc-qt.desktop";
      "video/x-flv" = "mpc-qt.desktop";
      "video/x-fli" = "mpc-qt.desktop";
      "video/x-m4v" = "mpc-qt.desktop";
      "video/x-ms-wmv" = "mpc-qt.desktop";
      "video/x-ms-asf" = "mpc-qt.desktop";
      "video/x-ogm" = "mpc-qt.desktop";

      "audio/mpeg" = "mpc-qt.desktop";
      "audio/mp3" = "mpc-qt.desktop";
      "audio/ogg" = "mpc-qt.desktop";
      "audio/flac" = "mpc-qt.desktop";
      "audio/wav" = "mpc-qt.desktop";
      "audio/x-wav" = "mpc-qt.desktop";
      "audio/aac" = "mpc-qt.desktop";
      "audio/x-m4a" = "mpc-qt.desktop";
      "audio/x-aac" = "mpc-qt.desktop";
      "audio/x-flac" = "mpc-qt.desktop";
      "audio/x-ogg" = "mpc-qt.desktop";
      "audio/webm" = "mpc-qt.desktop";
      "audio/x-ms-wma" = "mpc-qt.desktop";
      "audio/midi" = "mpc-qt.desktop";
      "audio/x-midi" = "mpc-qt.desktop";
      "audio/x-musepack" = "mpc-qt.desktop";

      "application/pdf" = "onlyoffice-desktopeditors.desktop";
      "application/msword" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.ms-word" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.ms-excel" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.ms-powerpoint" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" = "onlyoffice-desktopeditors.desktop";
      "text/csv" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.text" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.spreadsheet" = "onlyoffice-desktopeditors.desktop";
      "application/vnd.oasis.opendocument.presentation" = "onlyoffice-desktopeditors.desktop";
      "application/rtf" = "onlyoffice-desktopeditors.desktop";
      "text/rtf" = "onlyoffice-desktopeditors.desktop";

      "application/zip" = "ark.desktop";
      "application/x-zip-compressed" = "ark.desktop";
      "application/x-tar" = "ark.desktop";
      "application/x-gzip" = "ark.desktop";
      "application/x-bzip2" = "ark.desktop";
      "application/x-xz" = "ark.desktop";
      "application/x-7z-compressed" = "ark.desktop";
      "application/x-rar" = "ark.desktop";
      "application/x-rar-compressed" = "ark.desktop";
      "application/x-compress" = "ark.desktop";
      "application/x-xz-compressed" = "ark.desktop";
      "application/java-archive" = "ark.desktop";
      "application/x-archive" = "ark.desktop";
      "application/x-cd-image" = "ark.desktop";
      "application/x-iso9660-image" = "ark.desktop";

      "model/gltf-binary" = "blender.desktop";
      "model/gltf+json" = "blender.desktop";
      "model/obj" = "blender.desktop";
      "application/x-blender" = "blender.desktop";
      "application/x-obj" = "blender.desktop";
      "application/vnd.blender" = "blender.desktop";
      "application/x-3ds" = "blender.desktop";
      "image/x-3ds" = "blender.desktop";
      "application/fbx" = "blender.desktop";
      "model/fbx" = "blender.desktop";
      "application/x-fbx" = "blender.desktop";

      "application/gcode" = "cura-appimage.desktop";
      "application/x-gcode" = "cura-appimage.desktop";
      "model/stl" = "cura-appimage.desktop";
      "application/sla" = "cura-appimage.desktop";
      "application/vnd.ms-3mfdocument" = "cura-appimage.desktop";
      "application/3mf" = "cura-appimage.desktop";
      "application/x-3mf" = "cura-appimage.desktop";
    };
  };
}
