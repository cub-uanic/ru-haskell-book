{-# LANGUAGe NoMonomorphismRestriction #-}

import Diagrams.Prelude
import Diagrams.Backend.Cairo.CmdLine

import Arrow
import Signs

c n  = text n # font "monospace" <> circle r # lw 0.1 # fc white

r = 1.5
d = 4

ah  = ahrule  d # lw 0.1
av  = avrule  d # lw 0.1


h  = hrule  d # lw 0.1
v  = vrule  d # lw 0.1

hv = scale 1.8 $ rotateBy (1/8) h 
ahv = scale 1.8 $ rotateBy (1/8) ah 


h1 a f b = pad 1.2 $ centerXY $ position [
        (origin, x1),
        (P (0, -d/2.05), alignL (ah1 ||| s1 ||| text "Nothing"))]   
    where x0 = centerXY $ hcat 
                [text a, s, ah, c f, ah, s, text b]
          x1 = x0 === scaleY 0.5 v
          s  = strutX 0.5
          s1 = strutX 2.2
          ah1 = ahrule  (d*1.25) # lw 0.1

h11 = h1 "a" "f" "b"
h12 = hcat [text "b", s, ah, c "g", ah, s, text "c"]
    where s  = strutX 0.5



h2 = pad 1.2 $ centerXY $ position [
        (origin, x1),
        (P (-r-d/2, -d/2.05), alignL $ hcat [ah1, s1, text "Nothing"]),
        (P (0, 2.2), text "b")]
    where x0 = centerXY $ hcat
                    [text "a", s, ah, c "f", ah, c "g", ah, s, text "c"]
          s  = strutX 0.5  
          s1 = strutX 2.2
          v1 = scaleY 0.5 v
          x1 = x0 === (centerXY $ hcat [v1, strutX (d+2*r), mempty])
          ah1 = ahrule  (2*r+d+d*1.25) # lw 0.1

res = vcat [
        centerX $ hcat [h11, strutX 3, h12],
        strutY 4,
        h2,
        strutY 4,
        h1 "a" (sign specToArr "f" "g") "c"]


main = defaultMain $ pad 1.1 $ centerXY res

