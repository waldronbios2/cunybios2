#!/bin/bash
n=6
sed -i "" -e "s/templatesession/session$n/" README.md DESCRIPTION _pkgdown.yml
sed -i "" -e "s/template_session/session$n/" README.md
sed -i "" -e "s/sessionN/session$n/" DESCRIPTION
sed -i "" -e "s/session N/session $n/" DESCRIPTION
sed -i "" -e "s/Session N/Session $n/" vignettes/session_lecture.Rmd vignettes/session_lab.Rmd 



