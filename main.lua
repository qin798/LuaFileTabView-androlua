require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.google.android.material.tabs.TabLayout"
import "java.io.File"

activity.setContentView(loadlayout(require"layout"))

mTab.setPath("/storage/emulated/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/nt_qq_f031d2c4cdb29dce5de1f9f465897ecd/Video/Thumb")
button.onClick = function()
  mTab.setPath(File(mTab.getPath()).getParent())
end
