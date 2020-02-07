syntax clear gitcommitSummary
syntax match gitcommitSummary "^.*" contained containedin=gitcommitFirstLine nextgroup=gitcommitOverflow contains=@Spell
