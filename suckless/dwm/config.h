/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx  = 3;        /* border pixel of windows */
static const Gap default_gap        = {.isgap = 1, .realgap = 10, .gappx = 10};
static const unsigned int snap      = 32;       /* snap pixel */
static const int showbar            = 1;        /* 0 means no bar */
static const int topbar             = 1;        /* 0 means bottom bar */
static const int vertpad            = 10;       /* vertical padding of bar */
static const int sidepad            = 10;       /* horizontal padding of bar */
static const int user_bh            = 35;        /* 0 means that dwm will calculate bar height, >= 1 means dwm will user_bh as bar height */
static const char *fonts[]          = { "FiraMono Nerd Font Bold:size=10" };
static const char dmenufont[]       = "FiraMono Nerd Font Bold:size=10";
static const char col_gray1[]       = "#222222";
static const char col_gray2[]       = "#444444";
static const char col_gray3[]       = "#bbbbbb";
static const char col_gray4[]       = "#eeeeee";
static const char col_cyan[]        = "#005577";
                  /* tokyo night scheme colors */
static const char dark_black[]        = "#1a1b26"; // status bar (bg)
static const char active_white[]        = "#bdc7f0"; // status bar (fg active)
static const char inactive_white[]        = "#959cbd"; // status bar (fg inactive)
                 /* rainbow Tags colors */
static const char col_red[]        = "#ff0000";
static const char col_orange[]        = "#ff7f00";
static const char col_yellow[]        = "#ffff00";
static const char col_green[]        = "#00ff00";
static const char col_cyan2[]        = "#2ac3de";
static const char col_purple[]        = "#7aa2f7";


static const char *colors[][3]      = {
	/*               fg         bg         border   */
	[SchemeNorm] = { col_gray3, col_gray1, col_gray2 },
	[SchemeSel]  = { col_gray4, col_cyan,  col_cyan  },
	[SchemeStatus]  = { active_white, dark_black,  "#000000"  }, // Statusbar right {text,background,not used but cannot be empty}
	[SchemeTagsSel]  = { active_white, dark_black,  "#000000"  }, // Tagbar left selected {text,background,not used but cannot be empty}
	[SchemeTagsNorm]  = { inactive_white, dark_black,  "#000000"  }, // Tagbar left unselected {text,background,not used but cannot be empty}
	[SchemeInfoSel]  = { active_white, dark_black,  "#000000"  }, // infobar middle  selected {text,background,not used but cannot be empty}
	[SchemeInfoNorm]  = { active_white, dark_black,  "#000000"  }, // infobar middle  unselected {text,background,not used but cannot be empty}

};

/* tagging */
static const char *tags[] = { ">_", "{..}", "www", "~/", "(ˇ▽ˇ)ノ♫", "¬‿¬"};

static const unsigned int ulinepad	= 5;	/* horizontal padding between the underline and tag */
static const unsigned int ulinestroke	= 2;	/* thickness / height of the underline */
static const unsigned int ulinevoffset	= 0;	/* how far above the bottom of the bar the line should appear */
static const int ulineall 		= 0;	/* 1 to show underline on all tags, 0 for just the active ones */

static const char *tagsel[][2] = {
	/*    fg           bg   */
	{ col_red, dark_black },
	{ col_orange, dark_black },
	{ col_yellow, dark_black },
	{ col_green, dark_black },
	{ col_cyan2, dark_black },
	{ col_purple, dark_black },
};

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class      instance    title       tags mask     isfloating   monitor */
	{ NULL,   "terminator",       NULL,       1,        0,           -1 },
	{ "st",         NULL,         NULL,       1,        0,           -1 },
	                              /* tag 2 */
	{ NULL,       "geany",       NULL,       1 << 1,        0,           -1 },
	{ NULL,       "code",       NULL,       1 << 1,        0,           -1 },
	{ NULL,       "gns3",       NULL,       1 << 1,        0,           -1 },
	                              /* tag 3 */
	{ "Firefox",     NULL,       NULL,       1 << 2,        0,           -1 },
	{ NULL,   "wireshark",       NULL,       1 << 2,        0,           -1 },
	                             /* tag 4 */
	{ NULL,  "thunar",       NULL,       1 << 3,        0,           -1 },
	                             /* tag 5 */
	{ "vlc",  NULL,       NULL,       1 << 4,        0,           -1 },
	{ "mpv",  NULL,       NULL,       1 << 4,        0,           -1 },
	                           /* current window */
	{ "Gimp",     NULL,       NULL,       0,            1,           -1 },
	
};

/* layout(s) */
static const float mfact     = 0.55; /* factor of master area size [0.05..0.95] */
static const int nmaster     = 1;    /* number of clients in master area */
static const int resizehints = 1;    /* 1 means respect size hints in tiled resizals */
static const int lockfullscreen = 1; /* 1 will force focus on the fullscreen window */

#include "tatami.c"
#include "layouts.c"
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "[]=",      tile },    /* first entry is default */
	{ "><>",      NULL },    /* no layout function means floating behavior */
	{ "[M]",      monocle },
	{ "|+|",      tatami },
	{ "HHH",      grid },
	{ NULL,       NULL },
};

/* key definitions */
#define MODKEY Mod1Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* commands */
static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[] = { "dmenu_run", "-m", dmenumon, "-fn", dmenufont, "-nb", col_gray1, "-nf", col_gray3, "-sb", col_cyan, "-sf", col_gray4, NULL };
static const char *termcmd[]  = { "st", NULL };
                          // volume
static const char *upvol[] = { "/usr/bin/amixer", "set", "Master", "5%+", NULL }; 
static const char *downvol[] = { "/usr/bin/amixer", "set", "Master", "5%-", NULL };
static const char *mutevol[] = {"/bin/bash", "-c", "amixer -D default sset Master Playback 0%" };
                         // Screen Lock
static const char *lockscreen[] = {"/bin/bash", "-c", "i3lock -c 0d1926 --clock --time-str '%I:%M%p' --date-str '%a %d %B %Y' --date-color '0883ff' --time-color 'ff0883' --date-size 20 --time-size 32" };

static const Key keys[] = {
	/* modifier                     key        function        argument */
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },
	{ MODKEY|ShiftMask,             XK_Return, spawn,          {.v = termcmd } },
	{ MODKEY,                       XK_b,      togglebar,      {0} },
	{ MODKEY|ShiftMask,             XK_j,      rotatestack,    {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_k,      rotatestack,    {.i = -1 } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY|ControlMask,           XK_h,      setcfact,       {.f = +0.25} },
	{ MODKEY|ControlMask,           XK_l,      setcfact,       {.f = -0.25} },
	{ MODKEY|ControlMask,           XK_o,      setcfact,       {.f =  0.00} },
	{ MODKEY,                       XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Tab,    view,           {0} },
	{ MODKEY|ShiftMask,             XK_c,      killclient,     {0} },
	{ MODKEY,                       XK_t,      setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_f,      setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_m,      setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_y,      setlayout,      {.v = &layouts[3]} },
	{ MODKEY,                       XK_g,      setlayout,      {.v = &layouts[4]} },
	{ MODKEY|ControlMask,		    XK_bracketleft,  cyclelayout,    {.i = -1 } },
	{ MODKEY|ControlMask,           XK_bracketright, cyclelayout,    {.i = +1 } },
	{ MODKEY,                       XK_space,  setlayout,      {0} },
	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },
	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },
	{ MODKEY|ShiftMask,             XK_comma,  tagmon,         {.i = -1 } },
	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_minus,  setgaps,        {.i = -5 } },
	{ MODKEY,                       XK_equal,  setgaps,        {.i = +5 } },
	{ MODKEY|ShiftMask,             XK_minus,  setgaps,        {.i = GAP_RESET } },
	{ MODKEY|ShiftMask,             XK_equal,  setgaps,        {.i = GAP_TOGGLE} },
	{ MODKEY,                       XK_F9,     spawn,          {.v = mutevol } },
	{ MODKEY,                       XK_F11,    spawn,          {.v = downvol } },
    { MODKEY,                       XK_F12,    spawn,          {.v = upvol } },
    { MODKEY,                       XK_s,      spawn,          { .v = lockscreen } },
	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static const Button buttons[] = {
	/* click                event mask      button          function        argument */
	{ ClkLtSymbol,          0,              Button1,        setlayout,      {0} },
	{ ClkLtSymbol,          0,              Button3,        setlayout,      {.v = &layouts[2]} },
	{ ClkWinTitle,          0,              Button2,        zoom,           {0} },
	{ ClkStatusText,        0,              Button2,        spawn,          {.v = termcmd } },
	{ ClkClientWin,         MODKEY,         Button1,        movemouse,      {0} },
	{ ClkClientWin,         MODKEY,         Button2,        togglefloating, {0} },
	{ ClkClientWin,         MODKEY,         Button3,        resizemouse,    {0} },
	{ ClkTagBar,            0,              Button1,        view,           {0} },
	{ ClkTagBar,            0,              Button3,        toggleview,     {0} },
	{ ClkTagBar,            MODKEY,         Button1,        tag,            {0} },
	{ ClkTagBar,            MODKEY,         Button3,        toggletag,      {0} },
};
