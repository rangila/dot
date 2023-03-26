--
-- xmonad example config file.
--
-- A template showing all available configuration hooks,
-- and how to override the defaults in your own xmonad.hs conf file.
--
-- Normally, you'd only override those defaults you care about.
--
import Data.Monoid
import System.Exit
import XMonad
import XMonad.Config.Kde
import XMonad.Actions.CycleWS
import XMonad.Actions.Submap
import XMonad.Hooks.ManageDocks (avoidStruts, ToggleStruts(..))
import XMonad.Hooks.ManageHelpers
import XMonad.Layout.Gaps
import XMonad.Layout.Spacing
import XMonad.Layout.NoBorders
import XMonad.Util.Cursor
import XMonad.Util.Run
import XMonad.Util.SpawnOnce
import XMonad.Hooks.InsertPosition

import XMonad.Layout.ResizableTile
import XMonad.Layout.PerScreen
import XMonad.Layout.Master
import XMonad.Layout.AvoidFloats
import XMonad.Layout.Maximize

import XMonad.Layout.LayoutScreens
import XMonad.Layout.LayoutBuilder
import XMonad.Layout.TwoPane
import XMonad.Layout.Simplest
import XMonad.Layout.DecorationMadness
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns

import qualified Data.Map as M
import qualified XMonad.StackSet as W
 
import Control.Monad
import Data.Maybe
import Data.List
import Data.Ratio


-- splitScreenLayout = (layoutN 1 (relBox 0.3 0.0 1.0 0.7) Nothing $ Simplest)
--                         $ (layoutN 1 (relBox 0.0 0.0 0.3 1.0) Nothing $ Simplest)
--                         $ (layoutAll (relBox 0.3 0.7 1.0 1.0) $ Simplest)
    
------------------------------------------------------------------------
-- Layouts:
-- You can specify and transform your layouts by modifying these values.
-- If you change layout bindings be sure to use 'mod-shift-space' after
-- restarting (with 'mod-q') to reset your layout state to the new
-- defaults, as xmonad preserves your old layout settings by default.
--
-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
--
myLayout =
    maximize
    $ avoidStruts 
    $ spacingRaw True (Border 0 10 10 10) True (Border 10 10 10 10) True 
    $ gaps [(U, 10), (D, 10), (R, 4)] 
    $ smartBorders
    $ ifWider 3000 high_resolution_layouts 
         (ifWider 2500 wide_resolution_layouts vertical_layouts)
  where
    wideTopRightAngleAbsoluteLayout = (layoutN 1 (absBox 1280 0 3840 1440) Nothing $ Simplest)
        $ (layoutN 1 (absBox 0 0 1280 1440) (Just $ absBox 0 0 1280 2160) $ Simplest)
        $ (layoutAll (absBox 0 1440 3840 2160) $ threeColumns)
    verticalHighResSegmentationLayout = (layoutN 1 (absBox 960 0 1200 2100) (Just $ absBox 0 0 2160 3840) $ Simplest)
        $ (layoutN 1 (absBox 0 0 960 2100) (Just $ absBox 0 2100 2160 3840) $ Simplest)
        $ (layoutAll (absBox 0 2100 2160 3840) $ threeColumns)
    -- default tiling algorithm partitions the screen into two panes
    threeColumns = ThreeColMid nmaster delta ratio
    -- The default number of windows in the master pane
    nmaster = 1
    -- Percent of screen to increment by when resizing panes
    delta = 3 / 100
    -- Default proportion of screen occupied by master pane
    ratio = 1 / 2
    high_resolution_layouts = avoidFloats $ wideTopRightAngleAbsoluteLayout ||| threeColumns ||| accordionSimpleTabbed
    wide_resolution_layouts = avoidFloats $ threeColumns ||| TwoPane (3/100) (1/2) ||| Full
    vertical_layouts = verticalHighResSegmentationLayout ||| Mirror threeColumns ||| accordionSimpleTabbed


clipFloat :: W.RationalRect -> W.RationalRect
clipFloat (W.RationalRect x y a b)
    | x < 0 || y < 0 = W.RationalRect (1 % 3) (1 % 3) a b
    | otherwise = W.RationalRect x y a b


setFullscreenSupported :: X ()
setFullscreenSupported = addSupported ["_NET_WM_STATE", "_NET_WM_STATE_FULLSCREEN"]

addSupported :: [String] -> X ()
addSupported props = withDisplay $ \dpy -> do
    r <- asks theRoot
    a <- getAtom "_NET_SUPPORTED"
    newSupportedList <- mapM (fmap fromIntegral . getAtom) props
    io $ do
      supportedList <- fmap (join . maybeToList) $ getWindowProperty32 dpy a r
      changeProperty32 dpy r a aTOM propModeReplace (nub $ newSupportedList ++ supportedList)

-- The preferred terminal program, which is used in a binding below and by
-- certain contrib modules.
--
myTerminal = "urxvt"

-- Whether focus follows the mouse pointer.
myFocusFollowsMouse :: Bool
myFocusFollowsMouse = True

-- Whether clicking on a window to focus also passes the click to the window
myClickJustFocuses :: Bool
myClickJustFocuses = True

-- Width of the window border in pixels.
--
myBorderWidth = 2

-- modMask lets you specify which modkey you want to use. The default
-- is mod1Mask ("left alt").  You may also consider using mod3Mask
-- ("right alt"), which does not conflict with emacs keybindings. The
-- "windows key" is usually mod4Mask.
--
myModMask = mod4Mask

-- The default number of workspaces (virtual screens) and their names.
-- By default we use numeric strings, but any string may be used as a
-- workspace name. The number of workspaces is determined by the length
-- of this list.
--
-- A tagging example:
--
-- > workspaces = ["web", "irc", "code" ] ++ map show [4..9]
--
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

-- Border colors for unfocused and focused windows, respectively.
--
myNormalBorderColor = "#dddddd"

myFocusedBorderColor = "#ff0000"

------------------------------------------------------------------------
-- Key bindings. Add, modify or remove key bindings here.
-- /usr/include/X11/keysymdef.h
-- lowercase first letter
--
myKeys conf@(XConfig {XMonad.modMask = modm}) =
    M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- , ((modm, xK_a), spawn "rofi -combi-modi window,drun -show combi -modi combi")
    , ((modm, xK_a), spawn "krunner")
    -- launch gmrun
    , ((modm .|. shiftMask, xK_a), spawn "dmenu_run -l 10 -fn Hack-30 -b -i")
    -- screenshot select to clipboard
    , ((modm, xK_Delete), spawn "sleep 0.2; scrot -e 'xclip -selection clipboard -t image/png -i $f' -sf")
    -- screenshot select to home
    , ((modm .|. shiftMask, xK_Delete), spawn "sleep 0.2; scrot -sf")
    -- screenshot desktop to home
    , ((modm .|. controlMask, xK_Delete), spawn "sleep 0.2; scrot")
    -- close focused window
    , ((modm .|. shiftMask, xK_q), kill)
     -- Rotate through the available layout algorithms
    , ((modm, xK_space), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm, xK_r), refresh)
    -- Move focus to the next window
    , ((modm, xK_Tab), windows W.focusDown)
    -- Move focus to the next window
    , ((modm, xK_t), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm, xK_c), windows W.focusUp)
    -- Move focus to the master window
    , ((modm, xK_m), windows W.focusMaster)
    -- Swap the focused window and the master window
    , ((modm, xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_t), windows W.swapDown)
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_c), windows W.swapUp)
    -- Shrink the master area
    , ((modm, xK_d), sendMessage Shrink)
    , ((modm .|. shiftMask, xK_d), sendMessage MirrorShrink)
    -- Expand the master area
    , ((modm, xK_f), sendMessage Expand)
    , ((modm .|. shiftMask, xK_f), sendMessage MirrorExpand)
    ,((modm .|. shiftMask, xK_b), sendMessage AvoidFloatToggle)
    ,((modm .|. controlMask, xK_b), withFocused $ sendMessage . AvoidFloatToggleItem)
    ,((modm .|. shiftMask .|. controlMask, xK_b), sendMessage (AvoidFloatSet False) >> sendMessage AvoidFloatClearItems)
    -- , ((modm, xK_backslash), withFocused (sendMessage . maximizeRestore))
    , ((modm, xK_semicolon), withFocused (sendMessage . maximizeRestore))
    -- Push window back into tiling
    , ((modm, xK_g), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm, xK_bracketright), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm, xK_bracketleft), sendMessage (IncMasterN (-1)))
    , ((modm, xK_slash ), sendMessage $ IncLayoutN (-1))
    , ((modm, xK_equal ), sendMessage $ IncLayoutN 1)
    , ((modm, xK_h), prevScreen)
    , ((modm, xK_n), nextScreen)
    , ((modm .|. shiftMask, xK_h), shiftPrevScreen >> prevScreen)
    , ((modm .|. shiftMask, xK_n), shiftNextScreen >> nextScreen)
    --  , ((modm .|. shiftMask,                 xK_space), layoutSplitScreen 3 splitScreenLayout )
    --  , ((modm .|. controlMask .|. shiftMask, xK_space), rescreen)
    -- Toggle the status bar gap
    -- Use this binding with avoidStruts from Hooks.ManageDocks.
    -- See also the statusBar function from Hooks.DynamicLog.
    --
    -- , ((modm              , xK_b     ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_z), 
            spawn "dbus-send --print-reply --dest=org.kde.ksmserver /KSMServer org.kde.KSMServerInterface.logout int32:1 int32:0 int32:1")
    -- Restart xmonad
    , ((modm, xK_z), spawn "xmonad --recompile; xmonad --restart")
    ] ++
    [ ( (modm, xK_b)
      , submap . M.fromList $
        [ ((0, xK_p), spawn "google-chrome --proxy-server=localhost:3128")
        , ((0, xK_n), spawn "google-chrome --no-proxy-server")
        , ((0, xK_k), spawn "pkill chrome")
        , ((0, xK_t), spawn "xsetwacom set 'Wacom Intuos M Pen stylus' MapToOutput HEAD-0")
        ])
    ] ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [ ((m .|. modm, k), windows $ f i)
    | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
    , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]
    ] ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [ ((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
    | (key, sc) <- zip [xK_apostrophe, xK_comma, xK_period] [0 ..]
    , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]
    ]

------------------------------------------------------------------------
-- Mouse bindings: default actions bound to mouse events
--
myMouseBindings (XConfig {XMonad.modMask = modm}) =
    M.fromList $
    -- mod-button1, Set the window to floating mode and move by dragging
    [ ((modm, button1), (\w -> focus w >> mouseMoveWindow w >> windows W.shiftMaster))
    -- mod-button2, Raise the window to the top of the stack
    , ((modm, button2), (\w -> focus w >> windows W.shiftMaster))
    -- mod-button3, Set the window to floating mode and resize by dragging
    , ((modm, button3), (\w -> focus w >> mouseResizeWindow w >> windows W.shiftMaster))
    -- you may also bind events to the mouse scroll wheel (button4 and button5)
    ]

------------------------------------------------------------------------
-- Window rules:
-- Execute arbitrary actions and WindowSet manipulations when managing
-- a new window. You can use this to, for example, always float a
-- particular program, or have a client always appear on a particular
-- workspace.
--
-- To find the property name associated with a program, use
-- > xprop | grep WM_CLASS
-- and click on the client you're interested in.
--
-- To match on the WM_NAME, you can use 'title' in the same way that
-- 'className' and 'resource' are used below.
--
myManageHook =
    composeAll
        [ className =? "MPlayer" --> doFloat
        , className =? "qjackctl" --> doFloat
        , className =? "valheim.x86_64" --> doFloat
        , className =? "ASTAS_GUI" --> doFloat
        , resource =? "desktop_window" --> doIgnore
        , resource =? "kdesktop" --> doIgnore
        -- , isDialog --> doCenterFloat
        , isDialog --> doFloatDep clipFloat
        ]

------------------------------------------------------------------------
-- Status bars and logging
-- Perform an arbitrary action on each internal state change or X event.
-- See the 'XMonad.Hooks.DynamicLog' extension for examples.
--
myLogHook = return ()

------------------------------------------------------------------------
-- Startup hook
-- Perform an arbitrary action each time xmonad starts or is restarted
-- with mod-q.  Used by, e.g., XMonad.Layout.PerWorkspace to initialize
-- per-workspace layout choices.
--
-- By default, do nothing.
myStartupHook = return ()
    -- do
    -- spawnOnce "xset -dpms s off"
    -- setFullscreenSupported

-- -- setDefaultCursor xC_pirate
------------------------------------------------------------------------
-- Now run xmonad with all the defaults we set up.
-- Run xmonad with the settings you specify. No need to modify this.
--
main = do
    xmonad kde4Config
        { terminal = myTerminal
        , focusFollowsMouse = myFocusFollowsMouse
        , clickJustFocuses = myClickJustFocuses
        , borderWidth = myBorderWidth
        , modMask = myModMask
        , workspaces = myWorkspaces
        , normalBorderColor = myNormalBorderColor
        , focusedBorderColor = myFocusedBorderColor
      -- key bindings
        , keys = myKeys
        , mouseBindings = myMouseBindings
      -- hooks, layouts
        , layoutHook = myLayout
        , manageHook = manageHook kde4Config <+> myManageHook 
        , logHook = myLogHook
        , startupHook = myStartupHook
        }

