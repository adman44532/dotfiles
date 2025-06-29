{
  pkgs,
  user,
  ...
}: {
  home-manager.users.${user}.programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      keybinds = {
        locked = {
          "Ctrl g" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
        };
        resize = {
          "Ctrl n" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          h = {
            action = "Resize";
            direction = "Increase Left";
          };
          Left = {
            action = "Resize";
            direction = "Increase Left";
          };
          j = {
            action = "Resize";
            direction = "Increase Down";
          };
          Down = {
            action = "Resize";
            direction = "Increase Down";
          };
          k = {
            action = "Resize";
            direction = "Increase Up";
          };
          Up = {
            action = "Resize";
            direction = "Increase Up";
          };
          l = {
            action = "Resize";
            direction = "Increase Right";
          };
          Right = {
            action = "Resize";
            direction = "Increase Right";
          };
          H = {
            action = "Resize";
            direction = "Decrease Left";
          };
          J = {
            action = "Resize";
            direction = "Decrease Down";
          };
          K = {
            action = "Resize";
            direction = "Decrease Up";
          };
          L = {
            action = "Resize";
            direction = "Decrease Right";
          };
          "=" = {
            action = "Resize";
            direction = "Increase";
          };
          "+" = {
            action = "Resize";
            direction = "Increase";
          };
          "-" = {
            action = "Resize";
            direction = "Decrease";
          };
        };
        pane = {
          "Ctrl p" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          h = {
            action = "MoveFocus";
            direction = "Left";
          };
          Left = {
            action = "MoveFocus";
            direction = "Left";
          };
          l = {
            action = "MoveFocus";
            direction = "Right";
          };
          Right = {
            action = "MoveFocus";
            direction = "Right";
          };
          j = {
            action = "MoveFocus";
            direction = "Down";
          };
          Down = {
            action = "MoveFocus";
            direction = "Down";
          };
          k = {
            action = "MoveFocus";
            direction = "Up";
          };
          Up = {
            action = "MoveFocus";
            direction = "Up";
          };
          p = {action = "SwitchFocus";};
          n = [
            {action = "NewPane";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          d = [
            {
              action = "NewPane";
              direction = "Down";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          r = [
            {
              action = "NewPane";
              direction = "Right";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          x = [
            {action = "CloseFocus";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          f = [
            {action = "ToggleFocusFullscreen";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          z = [
            {action = "TogglePaneFrames";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          w = [
            {action = "ToggleFloatingPanes";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          e = [
            {action = "TogglePaneEmbedOrFloating";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          c = [
            {
              action = "SwitchToMode";
              mode = "RenamePane";
            }
            {
              action = "PaneNameInput";
              value = 0;
            }
          ];
          i = [
            {action = "TogglePanePinned";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
        };
        move = {
          "Ctrl h" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          n = {action = "MovePane";};
          Tab = {action = "MovePane";};
          p = {action = "MovePaneBackwards";};
          h = {
            action = "MovePane";
            direction = "Left";
          };
          Left = {
            action = "MovePane";
            direction = "Left";
          };
          j = {
            action = "MovePane";
            direction = "Down";
          };
          Down = {
            action = "MovePane";
            direction = "Down";
          };
          k = {
            action = "MovePane";
            direction = "Up";
          };
          Up = {
            action = "MovePane";
            direction = "Up";
          };
          l = {
            action = "MovePane";
            direction = "Right";
          };
          Right = {
            action = "MovePane";
            direction = "Right";
          };
        };
        tab = {
          "Ctrl t" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          r = [
            {
              action = "SwitchToMode";
              mode = "RenameTab";
            }
            {
              action = "TabNameInput";
              value = 0;
            }
          ];
          h = {action = "GoToPreviousTab";};
          Left = {action = "GoToPreviousTab";};
          Up = {action = "GoToPreviousTab";};
          k = {action = "GoToPreviousTab";};
          l = {action = "GoToNextTab";};
          Right = {action = "GoToNextTab";};
          Down = {action = "GoToNextTab";};
          j = {action = "GoToNextTab";};
          n = [
            {action = "NewTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          x = [
            {action = "CloseTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          s = [
            {action = "ToggleActiveSyncTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          b = [
            {action = "BreakPane";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "]" = [
            {action = "BreakPaneRight";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "[" = [
            {action = "BreakPaneLeft";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "1" = [
            {
              action = "GoToTab";
              index = 1;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "2" = [
            {
              action = "GoToTab";
              index = 2;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "3" = [
            {
              action = "GoToTab";
              index = 3;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "4" = [
            {
              action = "GoToTab";
              index = 4;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "5" = [
            {
              action = "GoToTab";
              index = 5;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "6" = [
            {
              action = "GoToTab";
              index = 6;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "7" = [
            {
              action = "GoToTab";
              index = 7;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "8" = [
            {
              action = "GoToTab";
              index = 8;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "9" = [
            {
              action = "GoToTab";
              index = 9;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          Tab = {action = "ToggleTab";};
        };
        scroll = {
          "Ctrl s" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          e = [
            {action = "EditScrollback";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          s = [
            {
              action = "SwitchToMode";
              mode = "EnterSearch";
            }
            {
              action = "SearchInput";
              value = 0;
            }
          ];
          "Ctrl c" = [
            {action = "ScrollToBottom";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          j = {action = "ScrollDown";};
          Down = {action = "ScrollDown";};
          k = {action = "ScrollUp";};
          Up = {action = "ScrollUp";};
          "Ctrl f" = {action = "PageScrollDown";};
          PageDown = {action = "PageScrollDown";};
          Right = {action = "PageScrollDown";};
          l = {action = "PageScrollDown";};
          "Ctrl b" = {action = "PageScrollUp";};
          PageUp = {action = "PageScrollUp";};
          Left = {action = "PageScrollUp";};
          h = {action = "PageScrollUp";};
          d = {action = "HalfPageScrollDown";};
          u = {action = "HalfPageScrollUp";};
        };
        search = {
          "Ctrl s" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          "Ctrl c" = [
            {action = "ScrollToBottom";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          j = {action = "ScrollDown";};
          Down = {action = "ScrollDown";};
          k = {action = "ScrollUp";};
          Up = {action = "ScrollUp";};
          "Ctrl f" = {action = "PageScrollDown";};
          PageDown = {action = "PageScrollDown";};
          Right = {action = "PageScrollDown";};
          l = {action = "PageScrollDown";};
          "Ctrl b" = {action = "PageScrollUp";};
          PageUp = {action = "PageScrollUp";};
          Left = {action = "PageScrollUp";};
          h = {action = "PageScrollUp";};
          d = {action = "HalfPageScrollDown";};
          u = {action = "HalfPageScrollUp";};
          n = {
            action = "Search";
            direction = "down";
          };
          p = {
            action = "Search";
            direction = "up";
          };
          c = {
            action = "SearchToggleOption";
            option = "CaseSensitivity";
          };
          w = {
            action = "SearchToggleOption";
            option = "Wrap";
          };
          o = {
            action = "SearchToggleOption";
            option = "WholeWord";
          };
        };
        entersearch = {
          "Ctrl c" = {
            action = "SwitchToMode";
            mode = "Scroll";
          };
          Esc = {
            action = "SwitchToMode";
            mode = "Scroll";
          };
          Enter = {
            action = "SwitchToMode";
            mode = "Search";
          };
        };
        renametab = {
          "Ctrl c" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          Esc = [
            {action = "UndoRenameTab";}
            {
              action = "SwitchToMode";
              mode = "Tab";
            }
          ];
        };
        renamepane = {
          "Ctrl c" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          Esc = [
            {action = "UndoRenamePane";}
            {
              action = "SwitchToMode";
              mode = "Pane";
            }
          ];
        };
        session = {
          "Ctrl o" = {
            action = "SwitchToMode";
            mode = "Normal";
          };
          "Ctrl s" = {
            action = "SwitchToMode";
            mode = "Scroll";
          };
          d = {action = "Detach";};
          w = [
            {
              action = "LaunchOrFocusPlugin";
              plugin = "session-manager";
              floating = true;
              move_to_focused_tab = true;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          c = [
            {
              action = "LaunchOrFocusPlugin";
              plugin = "configuration";
              floating = true;
              move_to_focused_tab = true;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          p = [
            {
              action = "LaunchOrFocusPlugin";
              plugin = "plugin-manager";
              floating = true;
              move_to_focused_tab = true;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          a = [
            {
              action = "LaunchOrFocusPlugin";
              plugin = "zellij:about";
              floating = true;
              move_to_focused_tab = true;
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
        };
        tmux = {
          "[" = {
            action = "SwitchToMode";
            mode = "Scroll";
          };
          "Ctrl b" = [
            {
              action = "Write";
              bytes = [2];
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "\"" = [
            {
              action = "NewPane";
              direction = "Down";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "%" = [
            {
              action = "NewPane";
              direction = "Right";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          z = [
            {action = "ToggleFocusFullscreen";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          c = [
            {action = "NewTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          "," = {
            action = "SwitchToMode";
            mode = "RenameTab";
          };
          p = [
            {action = "GoToPreviousTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          n = [
            {action = "GoToNextTab";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          Left = [
            {
              action = "MoveFocus";
              direction = "Left";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          Right = [
            {
              action = "MoveFocus";
              direction = "Right";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          Down = [
            {
              action = "MoveFocus";
              direction = "Down";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          Up = [
            {
              action = "MoveFocus";
              direction = "Up";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          h = [
            {
              action = "MoveFocus";
              direction = "Left";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          l = [
            {
              action = "MoveFocus";
              direction = "Right";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          j = [
            {
              action = "MoveFocus";
              direction = "Down";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          k = [
            {
              action = "MoveFocus";
              direction = "Up";
            }
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
          o = {action = "FocusNextPane";};
          d = {action = "Detach";};
          Space = {action = "NextSwapLayout";};
          x = [
            {action = "CloseFocus";}
            {
              action = "SwitchToMode";
              mode = "Normal";
            }
          ];
        };
        shared_except = {
          locked = {
            "Ctrl g" = {
              action = "SwitchToMode";
              mode = "Locked";
            };
            "Ctrl q" = {action = "Quit";};
            "Alt f" = {action = "ToggleFloatingPanes";};
            "Alt n" = {action = "NewPane";};
            "Alt i" = {
              action = "MoveTab";
              direction = "Left";
            };
            "Alt o" = {
              action = "MoveTab";
              direction = "Right";
            };
            "Alt h" = {
              action = "MoveFocusOrTab";
              direction = "Left";
            };
            "Alt Left" = {
              action = "MoveFocusOrTab";
              direction = "Left";
            };
            "Alt l" = {
              action = "MoveFocusOrTab";
              direction = "Right";
            };
            "Alt Right" = {
              action = "MoveFocusOrTab";
              direction = "Right";
            };
            "Alt j" = {
              action = "MoveFocus";
              direction = "Down";
            };
            "Alt Down" = {
              action = "MoveFocus";
              direction = "Down";
            };
            "Alt k" = {
              action = "MoveFocus";
              direction = "Up";
            };
            "Alt Up" = {
              action = "MoveFocus";
              direction = "Up";
            };
            "Alt =" = {
              action = "Resize";
              direction = "Increase";
            };
            "Alt +" = {
              action = "Resize";
              direction = "Increase";
            };
            "Alt -" = {
              action = "Resize";
              direction = "Decrease";
            };
            "Alt [" = {action = "PreviousSwapLayout";};
            "Alt ]" = {action = "NextSwapLayout";};
          };
          "normal locked" = {
            Enter = {
              action = "SwitchToMode";
              mode = "Normal";
            };
            Esc = {
              action = "SwitchToMode";
              mode = "Normal";
            };
          };
          "pane locked" = {
            "Ctrl p" = {
              action = "SwitchToMode";
              mode = "Pane";
            };
          };
          "resize locked" = {
            "Ctrl n" = {
              action = "SwitchToMode";
              mode = "Resize";
            };
          };
          "scroll locked" = {
            "Ctrl s" = {
              action = "SwitchToMode";
              mode = "Scroll";
            };
          };
          "session locked" = {
            "Ctrl o" = {
              action = "SwitchToMode";
              mode = "Session";
            };
          };
          "tab locked" = {
            "Ctrl t" = {
              action = "SwitchToMode";
              mode = "Tab";
            };
          };
          "move locked" = {
            "Ctrl h" = {
              action = "SwitchToMode";
              mode = "Move";
            };
          };
          "tmux locked" = {
            "Ctrl b" = {
              action = "SwitchToMode";
              mode = "Tmux";
            };
          };
        };
      };

      plugins = {
        tab-bar = {location = "zellij:tab-bar";};
        status-bar = {location = "zellij:status-bar";};
        strider = {location = "zellij:strider";};
        compact-bar = {location = "zellij:compact-bar";};
        session-manager = {location = "zellij:session-manager";};
        welcome-screen = {
          location = "zellij:session-manager";
          welcome_screen = true;
        };
        filepicker = {
          location = "zellij:strider";
          cwd = "/";
        };
        configuration = {location = "zellij:configuration";};
        plugin-manager = {location = "zellij:plugin-manager";};
        about = {location = "zellij:about";};
      };
    };
  };
}
