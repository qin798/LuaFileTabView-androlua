require "import"
import "android.app.*"
import "android.os.*"
import "android.widget.*"
import "android.view.*"
import "com.google.android.material.tabs.TabLayout"
import "java.io.File"
import "vinx.material.textfield.MaterialTextField"
import "com.google.android.material.button.MaterialButton"
import "com.google.android.material.checkbox.MaterialCheckBox"
MDC_R = luajava.bindClass "com.google.android.material.R"
LuaThemeUtil = luajava.newInstance("github.daisukiKaffuChino.utils.LuaThemeUtil",activity)

activity.setTitle("LuaFileTabView")
.setContentView(loadlayout(require"layout"))

local path = "/storage/emulated/0/Android/data/com.tencent.mobileqq/Tencent/QQfile_recv/nt_qq_f031d2c4cdb29dce5de1f9f465897ecd/Video/Thumb"

--mTab.setPath(path)
file_path.setText(path)

ok_button.onClick = function()
  local p = tostring(file_path.getText())
  if p == "" then
    print("空的喵")
    return
  end
  mTab.setPath(p)
end

check.onClick = function()
  mTab.setCanSelectTab(check.isChecked())
  mTab.setPath(mTab.getPath())
end

--[[mTab.setOnTabSelected(function(tab)
  print(tab.getText())
end)]]
