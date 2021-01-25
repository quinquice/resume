% Intro Options
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{resume}[My Resume Template]
\LoadClass[9pt]{article}

% Package Imports
\RequirePackage{geometry}
\RequirePackage[hidelinks]{hyperref}
\RequirePackage{titlesec}
\RequirePackage{xcolor}
\RequirePackage{paracol}
\RequirePackage{eso-pic}
\RequirePackage{enumitem}
\RequirePackage{etoolbox}
\RequirePackage[sfdefault]{roboto}

% Define Ratios
\newcommand{\lcol}{0.78}
\newcommand{\rcol}{0.22}

% Custom Lengths
\newlength{\sidebarwidth}
\newlength{\headerheight}
\newlength{\margin}
\newlength{\colarea}

% Define Lengths and Set Margins
\setlength{\headerheight}{1.05in}
\setlength{\margin}{0.23in}

\setlength{\colarea}{\dimexpr \paperwidth - 4\margin}
\setlength{\columnsep}{2\margin}
\setlength{\sidebarwidth}{\dimexpr 2\margin + \rcol\colarea + 2pt}
\setlength{\parindent}{0pt}

\geometry{letterpaper, headheight=0in,
    top=\margin, bottom=\margin, left=\margin, right=\margin} 

% Define Colorscheme Options

\newbool{complex-colors}

\DeclareOption{blue}{
    \definecolor{headerbg}  {HTML}{4E4C67}
    \definecolor{sidebarbg} {HTML}{E4E1F4}
}

\DeclareOption{red}{
    \definecolor{headerbg}  {HTML}{A44A3F}
    \definecolor{sidebarbg} {HTML}{E9ECEC}
}

\DeclareOption{greyscale}{
    \definecolor{headerbg}  {HTML}{696969}
    \definecolor{sidebarbg} {HTML}{EEEEEE}
}

\ExecuteOptions{greyscale, blue}
\ProcessOptions\relax

\notbool{complex-colors}{
    \definecolor{subsectiontext}{HTML}{000000}
    \definecolor{maintext}      {HTML}{000000}
    \definecolor{mainbg}        {HTML}{FFFFFF}
    \definecolor{headertext}    {HTML}{FFFFFF}
    \colorlet{headersubtext}    {sidebarbg}
    \colorlet{sectiontext}      {headerbg}
}{}

% Add colored backgrounds to page
\AddToShipoutPictureBG{
    \put(0, 0){
        \color{mainbg}
        \rule{\paperwidth}{\paperheight}
    }
    \put(\LenToUnit{\paperwidth - \sidebarwidth}, 0){
        \color{sidebarbg}
        \rule{\sidebarwidth}{\dimexpr \paperheight - \headerheight}
    }
    \put(-3, \LenToUnit{\paperheight - \headerheight}){
        \color{headerbg}
        \rule{\dimexpr \paperwidth + 3pt}{\headerheight}
    }
}

% Section Styling
\titleformat{\section}{
    \color{sectiontext}
    \large\bfseries
}{}{0em}{}[\hrule height 0.1cm]

\titleformat{\subsection}{
    \color{subsectiontext}
    \small\bfseries\uppercase
}{}{0em}{}

\titleformat{\subsubsection}{
    \color{subsectiontext}
    \small
}{}{0em}{}

% Timeline Commands
\newcommand*{\additem}[1]{\item #1}

\newcommand{\subcompact}[4][]{
    \color{maintext}
    \subsubsection{#2} 
    \vspace{-5pt}
    \footnotesize
    \notblank{#3}{\emph{#3}}{}
    \notblank{#1}{\hfill \emph{#1}}{}
    \notblank{#4}{
        \begin{itemize}[noitemsep, nolistsep, leftmargin=*]
            \forcsvlist\additem{#4}
        \end{itemize}
    }{}
    \vspace{-5pt}
}

\newcommand{\compact}[4][]{
    \color{maintext}
    \subsection{#2} 
    \vspace{-5pt}
    \small
    \notblank{#3}{\emph{#3}}{}
    \notblank{#1}{\hfill \emph{#1}}{}
    \notblank{#4}{
        \begin{itemize}[noitemsep, nolistsep, leftmargin=*]
            \forcsvlist\additem{#4}
        \end{itemize}
    }{}
    \vspace{-5pt}
}

% Name command
\newcommand{\namesection}[2]{
    \color{headertext}
    \begin{minipage}[t][\dimexpr \headerheight - \margin][t]{\textwidth}
    \centering{ \fontsize{35}{42}\selectfont #1 }\\
    \vspace{5pt}
    \color{headersubtext}
    \centering{ \small #2 }
    \end{minipage}
}