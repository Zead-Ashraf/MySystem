/* See LICENSE file for copyright and license details. */
/* Default settings; can be overriden by command line. */

static int topbar = 1;                      /* -b  option; if 0, dmenu appears at bottom     */
static int fuzzy = 1;                      /* -F  option; if 0, dmenu doesn't use fuzzy matching     */
/* -fn option overrides fonts[0]; default X11 font or font set */
static const char *fonts[] = {
	"monospace:size=10"
};
static const char *prompt      = NULL;      /* -p  option; prompt to the left of input field */
static const char *colors[SchemeLast][2] = {
	/*     fg         bg       */
	[SchemeNorm] = { "#00a57e", "#1a1b26" },
	[SchemeSel] = { "#52ddb2", "#2b2f4a" },
	[SchemeSelHighlight] = { "#ffc978", "#1a1b26" },
	[SchemeNormHighlight] = { "#ffc978", "#1a1b26" },
	[SchemeOut] = { "#000000", "#00ffff" },
};
/* -l and -g options; controls number of lines and columns in grid if > 0 */
static unsigned int lines      = 0;
static unsigned int columns    = 0;

/* -h option; minimum height of a menu line */
static unsigned int lineheight = 44;
static unsigned int min_lineheight = 43;

/*
 * Characters not considered part of a word while deleting words
 * for example: " /?\"&[]"
 */
static const char worddelimiters[] = " ";

/* -n option; preselected item starting from 0 */
static unsigned int preselected = 0;

/* Size of the window border */
static unsigned int border_width = 2;
