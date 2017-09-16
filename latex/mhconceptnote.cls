%% Filename:     myconceptnote.cls                        -*- mode: latex -*-
%% Description:  LaTeX style file for simple concept notes
%% Author(s):    Michael Hucka <mhucka@caltech.edu>
%% Date created: 2015-11-25

\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{mhconceptnote}

\ProcessOptions
\LoadClass[11pt]{article}

% Latex package dependencies.
% .............................................................................

\RequirePackage[pdftex,rgb,dvipsnames,svgnames,hyperref,table]{xcolor}
\RequirePackage[letterpaper,centering,top=0.75in,total={6.5in,9.5in}]{geometry}
\RequirePackage{fourier}
\RequirePackage{microtype}
\RequirePackage{array}
\RequirePackage{booktabs}
\RequirePackage{xspace}
\RequirePackage{soul}
\RequirePackage{url}
\RequirePackage[square,numbers,sort&compress]{natbib}
\RequirePackage{scrextend}
\RequirePackage{xhfill}
\RequirePackage{suffix}
\RequirePackage[inline]{enumitem}
\RequirePackage{calc}
\RequirePackage{varwidth}
\RequirePackage[american]{varioref}
\RequirePackage[T1]{fontenc}
\RequirePackage{titlesec}
\RequirePackage[font={small,it}]{caption}
\RequirePackage{etoolbox}

\RequirePackage[pdftex]{graphicx}
\RequirePackage[pdftex,breaklinks=true,colorlinks=true,
bookmarks=false,pdfhighlight=/O,urlcolor=darkblue,
citecolor=darkred,linkcolor=darkblue]{hyperref}

\RequirePackage{pdfpages} % This must be placed after the inclusion of pdftex.


% Color definitions.
% .............................................................................

\definecolor{extremelylightgray}{gray}{0.97}
\definecolor{veryverylightgray}{gray}{0.95}
\definecolor{verylightgray}{gray}{0.9}
\definecolor{lightgray}{gray}{0.8}
\definecolor{mediumgray}{gray}{0.5}
\definecolor{darkgray}{gray}{0.3}
\definecolor{almostblack}{gray}{0.23}
\definecolor{lightyellow}{rgb}{0.98,0.94,0.7}
\definecolor{verylightyellow}{rgb}{0.97,0.95,0.85}
\definecolor{darkblue}{rgb}{0.1,0.4,0.55}
\definecolor{mediumgreen}{rgb}{0.1,0.6,0.3}
\definecolor{darkred}{rgb}{0.6,0,0.1}

% Style adjustments.
% .............................................................................

% Add "concept note" in light gray color on the front page and omit the page
% number from the front page.

\patchcmd{\@maketitle}{\@title}{\vspace*{-0.6in}\textcolor{gray}{\large Concept Note}\\[1.25ex]\@title{}}{}{}
\apptocmd{\maketitle}{\thispagestyle{empty}}{}{}

% Reduce spacing after section headings.

\titlespacing\section{0pt}{8pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\titlespacing\subsection{0pt}{8pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}
\titlespacing\subsubsection{0pt}{8pt plus 4pt minus 2pt}{0pt plus 2pt minus 2pt}

% Put a dot after section numbers.

\titlelabel{\thetitle.\quad}

% Make appendices start as "Appendix A." instead of "A."

\let\oldappendix\appendix
\renewcommand{\appendix}{%
  \oldappendix%
  \renewcommand{\thesection}{Appendix \Alph{section}}%
}

% Adjust paragraphs to be unindented, with a blank line between them.

\setlength{\parindent}{0pt}            % Unindented paragraphs, separated ...
\setlength{\parskip}{1.3ex}            % ... by roughly one blank line.
\setlength{\partopsep}{-1ex plus 0.1ex minus -0.2ex}
\setlength{\itemsep}{-0.25ex plus 0.15ex}

% 'booktabs' package adjustments:

\setlength{\cmidrulewidth}{0.3 pt}
\setlength{\lightrulewidth}{0.3 pt}
\setlength{\heavyrulewidth}{0.9 pt}

% Fix placement of figures & tables.  This keeps latex from shoving big
% floats to the end of a document when they are somewhat big, which it will
% do even if you put [htb] as the argument.

\setcounter{topnumber}{2}               % max num of floats at top of page
\setcounter{bottomnumber}{2}            % max num of floats at bottom of page
\renewcommand\topfraction{1.0}          % fraction that a top float can cover
\renewcommand\bottomfraction{1.0}       % fraction a bottom float can cover
\renewcommand\textfraction{0.0}        % >5% of a non-float page must be text
\renewcommand\floatpagefraction{0.9}   % float page must be 95% full

% Spacing of floats.

\setlength{\intextsep}{1.5em plus 4pt minus 0pt}
\setlength{\textfloatsep}{1.5em plus 4pt minus 0pt}

% Spacing of bibliography items.

\setlength{\bibsep}{1ex plus 0.3ex}

% Make floats that appear alone on a page appear at the top, rather than
% (as is the LaTeX default) appearing centered vertically on the page.

\setlength{\@fptop}{5pt}

% The following uses txtt for the typewriter font, instead of the default.

\renewcommand{\ttdefault}{txtt}

\DeclareMathAlphabet{\mathtt}{T1}{txtt}{m}{n}
\SetMathAlphabet{\mathtt}{bold}{T1}{txtt}{b}{n}
\def\Txtt@scale{0.96}
\edef\Txtt@@scale{s*[\csname Txtt@scale\endcsname]}%
\DeclareFontFamily{T1}{txtt}{\hyphenchar \font\m@ne}
\DeclareFontShape{T1}{txtt}{m}{n}{	% regular
     <-> \Txtt@@scale txtt%
}{}
\DeclareFontShape{T1}{txtt}{b}{n}{	% bold
     <-> \Txtt@@scale txbtt%
}{}


% Cross-reference macros.
% .............................................................................

% We load the varioref package and define a set of macros for referring to
% floats and sections in a consistent way, such that the entire reference
% ("Section X", "Figure Y", etc.) is made into a hyperlink -- not only "X"
% and "Y", as would be the case with using the normal approach of writing
% "Section~\vref{...}".  Since all figure, table and section number
% references are always capitalized (they are the proper names of the
% objects, after all), the problem of creating a macro is simplified.
% SBMLPkgSpec defines the following for this purpose:
%
%   \fig{...}
%   \tab{...}
%   \sec{...}
%
% In addition, it defines starred versions of the above:
%
%   \fig*{...}
%   \tab*{...}
%   \sec*{...}
%
% The starred versions are useful when you have two or more references in
% the same paragraph to a float or section that is located elsewhere in the
% document, to avoid having text like the following happen:
%
%   "In Figure 2 on the next page, blah blah blah.  Figure 2 on the
%   following page also blah blah blah."
%
% Using the unstarred version for the first reference and starred version
% for subsequent references avoids this, and will produce text like this:
% 
%   "In Figure 2 on the next page, blah blah blah.  Figure 2 also blah
%   blah blah."
%
% Note: this overrides the definition of \sec{...} from the AMS math
% package. I decided this is likely to be acceptable to users because
% in SBML's domain of activity, it is very unlikely that someone would
% write a mathematical formula using the \sec command in a latex document
% specifying an SBML Level 3 package.
%
% As an alternative, the following plain varioref macros will work:
%
% * Use \vref{...} for everything and it will insert Figure~X, Table~Y,
%   Section~Z, etc., as appropriate for the reference.  You do not need to
%   add the object name; in other words, don't write "Section~\vref{foo}",
%   write just "\vref{foo}".
%
% * Use \vref*{...} if the reference is in parentheses, like "(\vref*{...})".
%
% * At the beginning of a paragraph (and ONLY there), use \Vref*{...}.
%
% * For a range, use \vrefrange{startlabel}{endlabel}.
%
% To see actual examples of using this, grep for "vref" in *.tex in the
% JSBML User Guide directory.


\labelformat{chapter}{Chapter~#1}
\labelformat{table}{Table~#1}
\labelformat{figure}{Figure~#1}

\newcommand{\sectionlabel}{Section}
\newcommand{\normallabels}{\renewcommand{\sectionlabel}{Section}}

\labelformat{section}{\sectionlabel~#1}
\labelformat{subsection}{\sectionlabel~#1}
\labelformat{subsubsection}{\sectionlabel~#1}
\labelformat{paragraph}{\sectionlabel~#1}

\newcommand{\@commonRefNoStar}[1]{\xspace\Vref*{#1}\xspace}
\newcommand{\@commonRefStar}[1]{\ref{#1}\xspace}

\newcommand{\fig}[1]{\normallabels\@commonRefNoStar{#1}}
\WithSuffix\newcommand\fig*[1]{\normallabels\@commonRefStar{#1}}

\newcommand{\tab}[1]{\normallabels\@commonRefNoStar{#1}}
\WithSuffix\newcommand\tab*[1]{\normallabels\@commonRefStar{#1}}

\renewcommand{\sec}[1]{\normallabels\@commonRefNoStar{#1}}
\WithSuffix\newcommand\sec*[1]{\normallabels\@commonRefStar{#1}}


% Note-making commands.
% .............................................................................

\reversemarginpar  % Want these be put on the left, not the right.

\newcommand{\note}[1]{\mbox{}\marginpar{%
    \hspace{0pt}\fcolorbox{Gold}{lightyellow}%
    {\scriptsize\begin{minipage}[t]{0.8in}%
        \raggedright\textit{#1}%
      \end{minipage}}}}


% Overleaf detection.
% .............................................................................

% This next code came from https://tex.stackexchange.com/a/384168/8318
\begingroup\endlinechar=-1\relax
       \everyeof{\noexpand}%
       \edef\x{\endgroup\def\noexpand\homepath{%
         \@@input|"kpsewhich --var-value=HOME" }}\x

% This value came from my testing 2017-08-07.
\def\overleafhome{/home/wl}


% Version numbering.
% .............................................................................
% There is a package, gitinfo2 (https://github.com/Hightor/gitinfo2), which
% could be used to provide version number info into the document; however, it
% requires the use of a post-commit hook, which we can't use with Overleaf.
% The approach below is based on ideas found in the following resources:
%   http://b.wardje.eu/2013/08/automated-git-commit-number-in-latex.html
%   http://tex.stackexchange.com/a/75339/8318
% The essential point is to run the Latex command with the -shell-escape flag;
% e.g., pdflatex -shell-escape whitepaper.tex
%
% Unfortunately, it also turns out that the git command does not seem to
% work when run on Overleaf, so this whole thing is now wrapped in a test.
% On Overleaf, we only print the current date.

\ifx\homepath\overleafhome
  \newcommand{\dateAndVersion}{\normalsize\today}
\else
  \ifnum\pdfshellescape=1
    \message{Shell escapes enabled.}
    \newcommand{\dateAndVersion}{%
      \immediate\write18{git rev-list --count --full-history HEAD > \jobname.info}%
      {\normalsize\today\quad(File revision \input{\jobname.info}\unskip)}}
  \else
    % \message{Shell escape not enabled; cannot obtain git revision number.}
    \newcommand{\dateAndVersion}{\normalsize\today}
   \fi
\fi

% Miscellaneous random other commands.
% .............................................................................

\newcommand{\link}[2]{\textup{\ttfamily{\href{#1}{#2}}}}
\newcommand{\mailto}[1]{\link{mailto:#1}{#1}}


% The end.
% .............................................................................
