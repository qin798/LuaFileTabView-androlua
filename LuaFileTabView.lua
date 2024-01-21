local bindClass = luajava.bindClass
local class = require "modules.class"
local TabLayout = bindClass "com.google.android.material.tabs.TabLayout"
local String = bindClass "java.lang.String"
local table = table
local luajava_astable = luajava.astable
local table_remove = table.remove
local table_size = table.size
local table_concat = table.concat

-- private data
local my_path = ""
local onTabSelected = lambda():;
local select_tab = true
--

local splitPath = function(path)
  local t = luajava_astable(String(path).split("/"))
  table_remove(t,1)
  return t
end

local addListener = function(view)
  view.addOnTabSelectedListener({
    onTabSelected = function(tab)
      local count = view.getTabCount()
      local position = tab.getPosition()
      local now_array = splitPath(my_path)

      if position < count-1 then
        for i=1,count - position - 1 do
          view.removeTabAt(view.getTabCount()-1)
          table_remove(now_array)
        end
        my_path = "/" .. table_concat(now_array,"/")
      end

      return onTabSelected(tab)
    end,
  })
end

return class{
  extends = TabLayout,
  init = addListener,
  methods = {
    setPath = function(view,path,select)
      local now_array = splitPath(path)
      local last_array = splitPath(my_path)
      local now_array_size = table_size(now_array)
      local last_array_size = table_size(last_array)

      if now_array_size <= last_array_size then
        for i=0,last_array_size - now_array_size do
          view.removeTabAt(view.getTabCount() - 1)
        end
      end

      for k,v in ipairs(now_array) do
        local tab = view.getTabAt(k-1)

        if not tab then
          tab = view.newTab().setIcon(R.drawable.ic_round_chevron_left_24)
          view.addTab(tab)
        end

        tab.setText(v)
        local tab_view = tab.view
        if not select_tab then
          tab_view.setOnTouchListener(lambda():true)
        end
        local textView = tab_view.getChildAt(1)
        textView.setAllCaps(false)
      end

      local finalTab = view.getTabAt(view.getTabCount()-1)
      local finalTabView = finalTab.view
      if select != false then
        finalTabView.post({
          run = function(...)
            --[[local x = finalTabView.getX()
            if x>0 then
              view.smoothScrollTo(x,0)
            end]]
            finalTab.select()
          end
        })
      end

      my_path = path
    end,
    getPath = lambda():my_path;,
    setOnTabSelected = function(view,func)
      onTabSelected = func
      return view
    end,
    setCanSelectTab = function(view,b)
      select_tab = b
      return view
    end
  },
}