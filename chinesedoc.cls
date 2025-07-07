% 通用中文文档模板
% 基于 pkuthss 修改，去除北大特定信息和学位论文相关内容
% 保留中文排版格式和核心功能

% This work may be distributed and/or modified under the conditions of the
% LaTeX Project Public License, either version 1.3 of this license or (at
% your option) any later version.
% The latest version of this license is in
%   https://www.latex-project.org/lppl.txt
% and version 1.3 or later is part of all distributions of LaTeX version
% 2005/12/01 or later.

\NeedsTeXFormat{LaTeX2e}[1995/12/01]
\ProvidesClass{chinesedoc}
[2024/12/19 v1.0.0 Chinese document class]
\RequirePackage{iftex}
\unless\ifXeTeX
    \ClassError{chinesedoc}{%
        The only supported compiler of this template is XeLaTeX.
        Please change the compilation configuration to enable XeLaTeX.
    }
\fi
\DeclareOption{GBK}{
    \ClassError{chinesedoc}{%
        The only supported file encoding is UTF-8.
        Please remove the GBK option and change the encoding of all files to UTF-8.
    }
}

% eg. `\cdoc@int@boolopt{spacing}{true}' will expand to:
%   \newif\ifcdoc@opt@spacing \cdoc@opt@spacingtrue
%   \DeclareOption{spacing}{\cdoc@opt@spacingtrue}
%   \DeclareOption{nospacing}{\cdoc@opt@spacingfalse}
\def\cdoc@int@boolopt#1#2{
    \expandafter\newif\csname ifcdoc@opt@#1\endcsname
    \@nameuse{cdoc@opt@#1#2}
    \DeclareOption{#1}{\@nameuse{cdoc@opt@#1true}}
    \DeclareOption{no#1}{\@nameuse{cdoc@opt@#1false}}
}
% Whether to modify fonts.
\cdoc@int@boolopt{cnfont}{true}
% Whether to modify footnote format.
\cdoc@int@boolopt{cnfoot}{true}
% Whether to modify spacing.
\cdoc@int@boolopt{cnspace}{true}
% Whether to use some common settings for adjusting spacing.
\cdoc@int@boolopt{spacing}{true}
% Add PDF bookmark for table of contents.
\cdoc@int@boolopt{pdftoc}{true}
% Whether to enable the `\spacialchap' command.
\cdoc@int@boolopt{spechap}{true}
% Whether to automatically set up properties for generated PDF from user
% defined document information (author, title, etc.).
\cdoc@int@boolopt{pdfprop}{true}
% Whether to disable some infractions intended to make the style less ugly.
\cdoc@int@boolopt{ugly}{false}
% Whether to disable blank pages.
\cdoc@int@boolopt{openany}{false}
% Pass all other options to `ctexbook' document class.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
% Process all class options now.
\ProcessOptions\relax

% chinesedoc is based on ctexbook
\LoadClass{ctexbook}
% Provides support for `key = val' grammar.
\RequirePackage{keyval}
% Graphics support.
\RequirePackage{graphicx}
% Provides utilities for setting up page layout.
\RequirePackage{geometry}
% fancyhdr provides utilities for setting up headers and footers.
\RequirePackage{fancyhdr}
% Provides `\uline' used in `\maketitle' (but do not mess with `\emph').
\RequirePackage[normalem]{ulem}
% Suppresses warnings of font size substitutions.
\RequirePackage{anyfontsize}
% `\AtEndOfClass' used to avoid `PDF destination not defined' with setspace.
\AtEndOfClass{\RequirePackage[bookmarksnumbered,unicode]{hyperref}}

\ifcdoc@opt@cnfont
    \RequirePackage{amsmath}
    % Use Times New Roman / Arial for better compatibility.
    \ifXeTeX
        \RequirePackage{unicode-math}
        \setmathfont[
            Extension = .otf,
            BoldFont = XITSMath-Bold
        ]{XITSMath-Regular}
        \DeclareSymbolFont{CMlargesymbols}{OMX}{cmex}{m}{n}
        \let\sumop\relax\let\prodop\relax
        \DeclareMathSymbol{\sumop}{\mathop}{CMlargesymbols}{"50}
        \DeclareMathSymbol{\prodop}{\mathop}{CMlargesymbols}{"51}
        \renewcommand{\Box}{\raisebox{0.06em}{\mdlgwhtsquare}}
        \newcommand{\checkbox}{\raisebox{0.12em}{\checkmark}\hspace{-0.95em}\Box}

        \setmainfont[
            Extension = .otf,
            UprightFont = *-Regular,
            BoldFont = *-Bold,
            ItalicFont = *-Italic,
            BoldItalicFont = *-BoldItalic
        ]{XITS}
        \setsansfont[
            Extension = .otf,
            UprightFont = *-regular,
            BoldFont = *-bold,
            ItalicFont = *-italic,
            BoldItalicFont = *-bolditalic,
            Scale = 0.95
        ]{texgyreheros}
    \else
        \RequirePackage{textcomp, mathptmx, amssymb}
        \RequirePackage[scaled = 0.95]{helvet}
        \newcommand{\checkbox}{\checkmark\hspace{-0.8em}\Box}
    \fi
\else
    \RequirePackage{amssymb}
    \newcommand{\checkbox}{\checkmark\hspace{-0.8em}\Box}
\fi

\ifcdoc@opt@cnfoot
    % Circled text, cf. <https://tex.stackexchange.com/questions/7032/>.
    \RequirePackage{tikz}
    \newcommand*{\cdoc@int@circled}[1]{%
        \scalebox{0.8}{\tikz[baseline = {([yshift = -0.1\ccwd] char.base)}]{
            \node[
                shape = circle, draw = black, minimum size = 1.25\ccwd, inner sep = 0pt
            ] (char) {#1};
        }}%
    }
    % Use circled numbers as footnote symbols.
    \RequirePackage[perpage]{footmisc}
    \renewcommand*{\thefootnote}{\protect\cdoc@int@circled{\arabic{footnote}}}
    \renewcommand*{\thempfootnote}{\protect\cdoc@int@circled{\arabic{mpfootnote}}}
    % Provides utility to modify footnote spacing.
    \RequirePackage{scrextend}
    % Set up footnote spacing: whole paragraph indent 1.5 ccwd, 0.5 ccwd after mark.
    \deffootnote{1.5\ccwd}{0pt}{\thefootnotemark\hspace{0.5\ccwd}}
\fi

\ifcdoc@opt@cnspace
    % lineskip / baselineskip = 20 bp / (12 bp * (6 / 5)).
    \linespread{1.39}\selectfont
    % Provides utilities for setting TOC format; `titles' applied to avoid
    % interfering with LaTeX's own title mechanism.
    \RequirePackage[titles]{tocloft}
    \setlength{\cftbeforechapskip}{6bp plus 1bp}
    \setlength{\cftsecindent}{\ccwd}
    \setlength{\cftsubsecindent}{2\ccwd}
    \setlength{\cftsubsubsecindent}{4\ccwd}
    % `caption' modifies font size and separator of captions.  `subcaption'
    % provides functions similar to `subfigure'/`subfig' but does not clash with
    % `tocloft'; it clashes with `subfigure'/`subfig', but the error message will
    % say they cannot be used simultaneously.
    \RequirePackage{caption, subcaption}
    \ifcdoc@opt@ugly
        \DeclareCaptionFont{capfsize}{\fontsize{11bp}{13.2bp}}
    \else
        \DeclareCaptionFont{capfsize}{\zihao{5}}
    \fi
    \DeclareCaptionLabelSeparator{quad}{\quad}
    \captionsetup{font = capfsize, labelsep = quad}
    \captionsetup[sub]{font = capfsize}
\fi

\ifcdoc@opt@spacing
    % Make spacing nicer in some situations (eg. footnotes and verbatims).
    \RequirePackage{setspace}
    % Remove superfluous spacing between footnotes.
    \setlength{\footnotesep}{0pt}
    % Lists often appear to be too sparse when items are just one or two lines
    % long. Here we cancel the extra vertical spacing between list items.
    % The list margin is adjusted due to Chinese typesetting traditions.
    \RequirePackage{enumitem}
    \setlist{nolistsep, leftmargin = 1.5\parindent}
\fi

\ifcdoc@opt@spechap
    % This command is used to start a chapter without numbering, and correctly set
    % up the headers and footers in the chapter.
    \newcommand{\specialchap}[1]{%
        \chapter*{#1}\addcontentsline{toc}{chapter}{#1}
        \markboth{#1}{}\phantomsection%
    }
\fi

\AtBeginDocument{
    % Set up spacing for displayed formulae.
    \setlength{\abovedisplayskip}{\belowdisplayshortskip}
    \setlength{\belowdisplayskip}{\abovedisplayskip}

    \ifcdoc@opt@pdftoc
        % Add PDF bookmark for table of contents.
        \let\cdoc@tmp@tableofcontents\tableofcontents
        \renewcommand{\tableofcontents}{%
            \cdoc@int@pdfmark{\contentsname}{contents}
            \cdoc@tmp@tableofcontents%
        }
    \fi
    \ifcdoc@opt@openany
        \let\cleardoublepage\clearpage
    \fi
}

% eg. `\cdoc@int@infoitema{ctitle}' will expand to:
%   \def\ctitle#1{\def\@ctitle{#1}}
%   \define@key{cdoc@info}{ctitle}{\ctitle{#1}}
\def\cdoc@int@infoitema#1{
    \@namedef{#1}##1{\@namedef{@#1}{##1}}
    \define@key{cdoc@info}{#1}{\@nameuse{#1}{##1}}
}

% Set up document labels.
\def\label@titlepage{封面}
\def\label@ctitle{标题：}
\def\label@cauthor{作者：}
\def\label@date{日期：}
\def\label@ckeywords{关键词：}
\def\label@cabstract{摘要}
\def\label@eabstract{ABSTRACT}
\def\label@ekeywords{KEY WORDS:\ }

% Set up document information entries.
\cdoc@int@infoitema{ctitle}
\cdoc@int@infoitema{cauthor}
\cdoc@int@infoitema{date}
\cdoc@int@infoitema{ckeywords}
\cdoc@int@infoitema{etitle}
\cdoc@int@infoitema{eauthor}
\cdoc@int@infoitema{ekeywords}

% Set up page layout.
\geometry{a4paper, hmargin = 2.6cm, headheight = 0.5cm, headsep = 0.6cm}
\ifcdoc@opt@ugly
    \geometry{top = 3.1cm, bottom = 2.5cm, footskip = 0.8cm}
\else
    \geometry{top = 3.0cm, bottom = 3.1cm, footskip = 1.1cm}
\fi

% Set up chapter/section/... captions.
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}
\ctexset{
    chapter = {beforeskip = {0bp}, afterskip = {18bp plus 0.2ex}},
    section =
        {beforeskip = {20bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}},
    subsection =
        {beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}},
    subsubsection =
        {beforeskip = {12bp plus 1ex minus 0.2ex}, afterskip = {5bp plus 0.2ex}}
}
\ctexset{
    chapter = {nameformat = {}, titleformat = {}},
    subsubsection = {format = {\zihao{-4}\bfseries}}
}
\ifcdoc@opt@ugly
    \ctexset{
        chapter = {format = {\zihao{3}\bfseries\centering}},
        section = {format = {\zihao{4}\bfseries}},
        subsection = {format = {\fontsize{13bp}{15.6bp}\selectfont\bfseries}}
    }
\else
    \ctexset{
        chapter = {format = {\zihao{-2}\bfseries\centering}},
        section = {format = {\zihao{-3}\bfseries}},
        subsection = {format = {\zihao{4}\bfseries}}
    }
\fi

\def\label@denotation{主要符号对照表}
\def\label@acks{致谢}
\ctexset{
    listtablename  = {表格索引},
    listfigurename = {插图索引}
}

% The actual page style setup.
\fancypagestyle{plain}{
    \fancyhf{}\renewcommand*{\headrulewidth}{0.75bp}
    \fancyfoot[C]{\zihao{5}\normalfont{\thepage}}
    \if@twoside
        \fancyhead[CE]{\zihao{5}\normalfont{\@ctitle}}
        \fancyhead[CO]{\zihao{5}\normalfont{\nouppercase\leftmark}}
    \else
        \fancyhead[C]{\zihao{5}\normalfont{\nouppercase\leftmark}}
    \fi
}
\pagestyle{plain}

% This places a bookmark pointing to somewhere near the page header;
\def\cdoc@int@pdfmark#1#2{%
    \if@openright\cleardoublepage\else\clearpage\fi
    \pdfbookmark[0]{#1}{#2}%
}

% Typeset the title page.
\renewcommand{\maketitle}{%
    % Automatically generate properties for generated PDF.
    \newcommand*{\setpdfproperties}{%
        \hypersetup{
            pdfauthor = {\@cauthor}, pdftitle = {\@ctitle},
            pdfkeywords = {\@ckeywords}
        }%
    }
    \ifcdoc@opt@pdfprop
        \setpdfproperties
    \fi
    \maketitlenormal
}

% Typeset the title page.
\newcommand{\maketitlenormal}{%
    \cdoc@int@pdfmark{\label@titlepage}{titlepage}
    % Make the title page centered.
    \begin{titlepage}\centering
        \vspace*{2cm}
        % Title of the document.
        {%
            \ifcdoc@opt@ugly\zihao{-1}\else\zihao{1}\fi%
            \linespread{1.6}\selectfont\textbf{\@ctitle}%
        }
        \vfill
        % Information about the author.
        {%
            \zihao{3}\linespread{1.75}\selectfont
            \begin{tabular}{c}
                {\bfseries\label@cauthor}\@cauthor \\[1em]
                {\bfseries\label@date}\@date \\
            \end{tabular}%
        }
        \vspace*{2cm}
    \par\end{titlepage}%
}

% Typeset the Chinese abstract.
\newenvironment{cabstract}{%
    \cdoc@int@pdfmark{\label@cabstract}{cabstract}
    \chapter*{\label@cabstract}\markboth{\label@cabstract}{}%
}{% Keywords at the bottom of the page.
    \vfill\noindent\label@ckeywords{\@ckeywords}%
}

% Typeset the English abstract.
\newenvironment{eabstract}{%
    \cdoc@int@pdfmark{\label@eabstract}{eabstract}
    \chapter*{\sffamily\@etitle}\markboth{\label@eabstract}{}
    \begin{center}
        {\@eauthor} \\[2em]
        \textbf{\sffamily\label@eabstract}
    \end{center}\par%
}{% Keywords at the bottom of the page.
    \vfill\noindent\label@ekeywords{\@ekeywords}%
}

% Typeset the item of denotation.
\newlist{cdoc@denotation}{description}{1}
\setlist[cdoc@denotation]{%
    nosep,
    font=\normalfont,
    align=left,
    leftmargin=!, % sum of the following 3 lengths
    labelindent=0pt,
    labelwidth=5.5cm,
    labelsep*=0.5cm,
    itemindent=0pt,
}

% Typeset the denotation.
\newenvironment{denotation}[1][5.5cm]{%
    \cdoc@int@pdfmark{\label@denotation}{denotation}
    \chapter*{\label@denotation}\markboth{\label@denotation}{}%
    \vskip-30bp\zihao{-4}\begin{cdoc@denotation}[labelwidth=#1]
}{%
    \end{cdoc@denotation}
}

% Typeset the acknowledgments.
\def\acks{\chapter{\label@acks}}

\endinput 