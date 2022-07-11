local stdpath = vim.fn.stdpath

function doomnvim.update()
  (require "plenary.job")
    :new({
      command = "git",
      args = { "pull", "--ff-only" },
      cwd = stdpath "config",
      on_exit = function(_, return_val)
        if return_val == 0 then
          vim.notify("Updated!", "info", doomnvim.base_notification)
        else
          vim.notify("Update failed! Please try pulling manually.", "error", doomnvim.base_notification)
        end
      end,
    })
    :sync()
    vim.cmd("PackerSync")
end
