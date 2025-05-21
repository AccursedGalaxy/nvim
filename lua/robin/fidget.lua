-- Configure the fidget.nvim progress indicator (v1.0.0+ API)
require("fidget").setup({
  -- Options for the notification subsystem
  notification = {
    -- Default options for notifications
    default = {
      -- Default style for notifications
      name = nil,
      icon = nil,
      ttl = 3,  -- Time-to-live for notifications in seconds
      group = nil,
      priority = 50,
      redirect = nil,
      on_open = nil,
      on_close = nil,
    },
    
    -- Options for notification logs
    view = {
      stack_upwards = true,  -- Display notification items from bottom to top
      icon_separator = " ", -- Separator between group name and icon
      group_separator = "---", -- Separator between notification groups
      group_separator_hl = "Comment", -- Highlight group for the group separator
      render_message = nil,  -- Custom message rendering
    },
  },
  
  -- Options for the LSP progress subsystem
  progress = {
    poll_rate = 0,  -- How frequently to poll for progress messages
    suppress_on_insert = false, -- Whether to suppress new messages while in insert mode
    ignore_done_already = false, -- Ignore new tasks that are already complete
    ignore_empty_message = false, -- Ignore new tasks with an empty message
    
    -- Notifications for LSP progress
    notification = {
      -- Maximum number of notifications shown
      view = {
        stack_upwards = true,
        icon_separator = " ",
        group_separator = "---",
        group_separator_hl = "Comment",
      },
    },
    
    -- Customizing LSP progress format
    format = {
      -- Format for progress messages
      message = function(msg)
        return msg
      end,
      
      -- Format for the notification title
      title = function(task)
        return task.title
      end,
      
      -- Format for the notification icon
      icon = function(task)
        return task.kind or ""
      end,
      
      -- Format progress percentage
      percentage = nil,
      
      -- Format time remaining
      done = nil,
    },
    
    -- This is where the old options like spinner/display/etc went
    display = {
      render_limit = 16, -- How many notifications to show at once
    },
  },
  
  -- Routing of notifications
  routing = {
    max_width = nil,  -- Maximum width of notification messages
  },
})
