\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{template}
\LoadClass{article}

%----------------------------------------
% REQUIRED PACKAGES
%----------------------------------------

\RequirePackage[T1]{fontenc} % font encoding
\RequirePackage{tikz} % image manipulation
\RequirePackage[absolute,overlay]{textpos}
\RequirePackage{marvosym} % icons
\RequirePackage{parskip} % spacing beteween paragraphs
\RequirePackage{calc} % calculating progress bars and circles
\RequirePackage[none]{hyphenat} % disable hyphenation
\RequirePackage[scaled]{helvet}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax

%----------------------------------------
% COLOURS
%----------------------------------------

\definecolor{white}{RGB}{255,255,255}
\definecolor{gray}{HTML}{4D4D4D}
\definecolor{sidecolor}{HTML}{E7E7E7}
\definecolor{maincolor}{HTML}{000066}
\definecolor{maingray}{HTML}{B9B9B9}

%----------------------------------------
% PROGRESS CIRCLE
%----------------------------------------

\newcommand{\progresscircle}[4]{
  \begin{tikzpicture}
    \fill[maingray] (0,0) circle (#3);
    \fill[maincolor] (0,0) -- (0, #3)
      arc (90:90-3.6*#2:#3) -- (0,0);
    \fill[white] (0,0) circle (#4);
    \node (0,0) {\huge #1};
  \end{tikzpicture}
}

%----------------------------------------
% LANGUAGE
%----------------------------------------

\newcommand{\languagecircle}[2]{
	\progresscircle{#1}{#2}{1.9cm}{1.5cm}
}

%----------------------------------------
% SKILLS
%----------------------------------------

\newenvironment{skills}{
	\begin{tabular*}{\textwidth}{ll}
}{
	\end{tabular*}
}

\newcommand{\skill}[2]{
	\begin{tikzpicture}
		\node [anchor=west] at (.1,.8) {#1};
		\fill [fill=maingray] (0,0) rectangle (4,.5);
		\fill [fill={maincolor}] (0,0) rectangle (#2,.5);
	\end{tikzpicture}
}

%----------------------------------------
% MISC CONFIGURATIONS
%----------------------------------------

\renewcommand{\bfseries}{\color{gray}} % Make \textbf produce coloured text instead

\pagestyle{empty} % Disable headers and footers

\setlength{\parindent}{0pt} % Disable paragraph indentation

\renewcommand{\arraystretch}{1.5} % Increase spacing between rows in tables

\renewcommand\familydefault{\sfdefault} 

%----------------------------------------
% SIDEBAR DEFINITIONS
%----------------------------------------

\setlength{\TPHorizModule}{1cm} % Left margin
\setlength{\TPVertModule}{1cm} % Top margin

\newlength\imagewidth
\newlength\imagescale
\pgfmathsetlength{\imagewidth}{5cm}
\pgfmathsetlength{\imagescale}{\imagewidth/600}

\newcommand{\profilesection}[2]{\vspace{8pt}{\color{black!80} \huge #1 \rule[0.15\baselineskip]{#2}{1pt}}}

% Basic resume info command definitions
\newcommand{\profilepic}[1]{\renewcommand{\profilepic}{#1}}
\newcommand{\fullname}[1]{\renewcommand{\fullname}{#1}}
\newcommand{\jobtitle}[1]{\renewcommand{\jobtitle}{#1}}

\newcommand{\birthdate}[1]{\renewcommand{\birthdate}{#1}}
\newcommand{\email}[1]{\renewcommand{\email}{#1}}
\newcommand{\phone}[1]{\renewcommand{\phone}{#1}}
\newcommand{\address}[1]{\renewcommand{\address}{#1}}
\newcommand{\site}[1]{\renewcommand{\site}{#1}}
\newcommand{\aboutme}[1]{\renewcommand{\aboutme}{#1}}

% Command for printing the contact information icons
\newcommand*\icon[1]{\tikz[baseline=(char.base)]{\node[shape=circle,draw,inner sep=1pt, fill=maincolor,maincolor,text=white] (char) {#1};}}

%----------------------------------------
% SIDEBAR LAYOUT
%----------------------------------------

\newcommand{\sidebar}{
	% Gray sidebar background
	\begin{tikzpicture}[remember picture,overlay]
   		\node [rectangle, fill=sidecolor, anchor=north, minimum width=9cm, minimum height=\paperheight+1cm] (box) at (-5cm,0.5cm){};
	\end{tikzpicture}

	% Sidebar block

	\begin{textblock}{6}(0.5, 0.5)
			
		%------------------------------------------------
		
		\begin{center}
			\begin{tikzpicture}[x=\imagescale,y=-\imagescale]
				\clip (600/2, 600/2) circle (600/2);
				\node[anchor=north west, inner sep=0pt, outer sep=0pt] at (0,0) {\includegraphics[width=\imagewidth]{\profilepic}};
			\end{tikzpicture}
		\end{center}

		% Full name

		{\Huge\color{maincolor}\fullname}

		% Job Title

		{\Large\color{black}\jobtitle}

		% Personal Information

		\begin{tabular}{p{0.5cm} @{\hskip 0.5cm}p{5cm}}
			\textsc{\large\icon{\Heart}} & \birthdate \\
			\textsc{\large\icon{\Letter}} & \address \\
			\textsc{\large\icon{\Telefon}} & \phone \\
			\textsc{\large\icon{\Mundus}} & \site \\
			\textsc{\large\icon{@}} & \email
		\end{tabular}

		% About

		\profilesection{About me}{2.6cm}
			
		\begin{flushleft}
			\aboutme
		\end{flushleft}

	\end{textblock}
}

%----------------------------------------
% SECTION TITLE
%----------------------------------------

% Command to create the rounded boxes around the first three letters of section titles
\newcommand*\round[2]{%
	\tikz[baseline=(char.base)]\node[anchor=north west, draw,rectangle, inner sep=1.6pt, minimum size=5.5mm, text height=3.6mm, fill=#2,#2,text=white](char){#1};%
}

\renewcommand{\section}[1]{
	{%
		\color{maincolor}
		\textsc{\large\icon{\Forward}} \Large{#1}
	}
}

\renewcommand{\subsection}[1]{
	\par\vspace{.5\parskip}{
		\large\color{gray} #1
	}
	\par\vspace{.25\parskip}
}

%----------------------------------------
% DETAILED LIST ENVIRONMENT
%----------------------------------------

\newenvironment{dlist}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

\newcommand{\ditem}[4]{
	#1&\parbox[t]{0.82\textwidth}{
		\textbf{#2}
		\hfill
		{\footnotesize #3} \\
		#4\vspace{\parsep}
	}\\
}

%----------------------------------------
% SHORT LIST ENVIRONMENT
%----------------------------------------

\setlength{\tabcolsep}{0pt}

% New environment for the small list
\newenvironment{slist}{
	\begin{tabular*}{\textwidth}{@{\extracolsep{\fill}}ll}
}{
	\end{tabular*}
}

\newcommand{\sitem}[2]{
	#1&\parbox[t]{0.82\textwidth}{
		#2
	}\\
}

%----------------------------------------
% MARGINS
%----------------------------------------

\RequirePackage[left=7.6cm,top=0.1cm,right=1cm,bottom=0.2cm,nohead,nofoot]{geometry}
