# About this website

This site provides automatically rendered course notes for CUNY SPH
Biostatistics 2. This course consists of 10 sessions, and each session
has an individual GitHub repo with its own R pkgdown website. Those
session websites contain lecture and lab notes in html version, and
lecture slides as PDF. This site serves to:

1. provide a simple website with links to all lectures and labs
2. provide convenient access to all source code using Git Submodules
3. create a Docker image containing all source code, and with all 
dependencies needed to run any of the source code.

The template used for creating sessions is
https://github.com/waldronbios2/templatesession. This provides the
shell website, lecture, lab, and a GitHub Action for rendering and
deploying to GitHub Pages. Click the "Use this template" button to use
it as the template for a new GitHub repo. You can then use the
[sedhelper.sh] script to change session "N" to an actual number in the
places where it's needed.

[sedhelper.sh]: https://github.com/waldronbios2/templatesession/blob/master/sedhelper.sh

# About the author

[Levi Waldron](https://waldronlab.io) is an Associate Professor of Biostatistics at the CUNY SPH. He created this site for the first fully-online offering of CUNY SPH Biostatistics 2 in Fall 2020.
