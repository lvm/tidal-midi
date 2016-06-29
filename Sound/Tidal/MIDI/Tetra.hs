module Sound.Tidal.MIDI.Tetra where

import Sound.Tidal.Stream ((|+|),(|=|), merge, ParamPattern)

import Sound.Tidal.MIDI.Control

import Sound.Tidal.Parse
import Sound.Tidal.Pattern
import Sound.Tidal.Params

import Control.Applicative

-- sequences

makeSeqTracks = []
-- seqtrack1 = map ((Just 0). pF . (\x -> "seq1step" ++ show x)) [1..16]
-- seqtrack2 = map ((Just 0). pF . (\x -> "seq2step" ++ show x)) [1..16]
-- seqtrack3 = map ((Just 0) . pF . (\x -> "seq3step" ++ show x)) [1..16]
-- seqtrack4 = map ((Just 0) . pF . (\x -> "seq4step" ++ show x)) [1..16]


-- seqpatterns p' = map onlyValues events
--   where arc' = arc p'
--         events = arc' (0,1)
--         onlyValues = \(_, _, a) -> p a

-- sqnp i t p' = foldr (|+|) i (zipWith ($) t patterns)
--   where patterns = seqpatterns p'

-- sqnp1 d p' = sqnp (seq1dst $ p $ show d) seqtrack1 p'
-- sqnp2 d p' = sqnp (seq2dst $ p $ show d) seqtrack2 p'
-- sqnp3 d p' = sqnp (seq3dst $ p $ show d) seqtrack3 p'
-- sqnp4 d p' = sqnp (seq4dst $ p $ show d) seqtrack4 p'


-- makeSeqTracks = concat $ map makeSeqTrack [0..3]
--   where makeSeqTrack t = map (makeSeqStep t) [0..15]
--         makeSeqStep t s = NRPN (pF (makeName t s) (Just 0)) (makeCC t s) (0, 127) 0 passThru
--         makeName t s = "seq" ++ (show $ t + 1) ++ "step" ++ (show $ s + 1)
--         makeCC t s = (t * 16) + (s + 120)

tetraController :: ControllerShape
tetraController = ControllerShape { controls = [
                                  mrNRPN osc1freq_p 0 (0, 120),
                                  mrNRPN osc1detune_p 1 (0, 100),
                                  NRPN osc1shape_p 2 (0, 103) passThru,
                                  mNRPN osc1glide_p 3,
                                  NRPN osc1kbd_p 4 (0, 1) passThru,

                                  mrNRPN osc2freq_p 5 (0, 120),
                                  mrNRPN osc2detune_p 6 (0, 100),
                                  NRPN osc2shape_p 7 (0, 103) passThru,
                                  mNRPN osc2glide_p 8,
                                  NRPN osc2kbd_p 9 (0, 1) passThru,

                                  NRPN oscsync_p 10 (0, 1) passThru,
                                  NRPN glidemode_p 11 (0, 3) passThru,
                                  NRPN oscslop_p 12 (0, 5) passThru,
                                  mrNRPN oscmix_p 13 (0, 127),

                                  mNRPN noise_p 14,
                                  mrNRPN cutoff_p' 15 (0, 164),
                                  mNRPN resonance_p 16,
                                  mNRPN kamt_p 17,
                                  mNRPN audiomod_p 18,
                                  NRPN fpoles_p 19 (0, 1) passThru,

                                  -- filter envelope
                                  mrNRPN famt_p 20 (0, 254),
                                  mNRPN fvel_p 21,
                                  mNRPN fdel_p 22,
                                  mNRPN fatk_p 23,
                                  mNRPN fdcy_p 24,
                                  mNRPN fsus_p 25,
                                  mNRPN frel_p 26,


                                  mNRPN vcavol_p 27,
                                  mNRPN pan_p 28,
                                  mNRPN gain_p 29, -- max volume by default

                                  mrNRPN vamt_p 30 (0, 127), -- max vca envelope amount
                                  mNRPN vvel_p 31,
                                  mNRPN vdel_p 32,
                                  mNRPN attack_p' 33,
                                  mrNRPN decay_p' 34 (0, 127),
                                  mrNRPN sustain_p' 35 (0, 127),
                                  mNRPN release_p' 36,

                                  NRPN lfo1rate_p 37 (0, 166) passThru,
                                  NRPN lfo1shape_p 38 (0, 4) passThru,
                                  mNRPN lfo1amt_p 39,
                                  NRPN lfo1dest_p 40 (0, 43) passThru,
                                  NRPN lfo1sync_p 41 (0, 1) passThru,

                                  NRPN lfo2rate_p 42 (0, 166) passThru, -- unsynced
                                  NRPN lfo2shape_p 43 (0, 4) passThru,
                                  mNRPN lfo2amt_p 44,
                                  NRPN lfo2dest_p 45 (0, 43) passThru,
                                  NRPN lfo2sync_p 46 (0, 1) passThru,

                                  NRPN lfo3rate_p 47 (0, 166) passThru, -- unsynced
                                  NRPN lfo3shape_p 48 (0, 4) passThru,
                                  mNRPN lfo3amt_p 49,
                                  NRPN lfo3dest_p 50 (0, 43) passThru,
                                  NRPN lfo3sync_p 51 (0, 1) passThru,

                                  NRPN lfo4rate_p 52 (0, 166) passThru, -- unsynced
                                  NRPN lfo4shape_p 53 (0, 4) passThru,
                                  mNRPN lfo4amt_p 54,
                                  NRPN lfo4dest_p 55 (0, 43) passThru,
                                  NRPN lfo4sync_p 56 (0, 1) passThru,

                                  NRPN emod_p 57 (0, 43) passThru,
                                  mrNRPN eamt_p 58 (0, 254),
                                  mNRPN evel_p 59,
                                  mNRPN edel_p 60,
                                  mNRPN eatk_p 61,
                                  mNRPN edcy_p 62,
                                  mNRPN esus_p 63,
                                  mNRPN erel_p 64,

                                  NRPN mod1src_p 65 (0, 20) passThru,
                                  mrNRPN mod1amt_p 66 (0, 254),
                                  NRPN mod1dst_p 67 (0, 47) passThru,

                                  NRPN mod2src_p 68 (0, 20) passThru,
                                  mrNRPN mod2amt_p 69 (0, 254),
                                  NRPN mod2dst_p 70 (0, 47) passThru,

                                  NRPN mod3src_p 71 (0, 20) passThru,
                                  mrNRPN mod3amt_p 72 (0, 254),
                                  NRPN mod3dst_p 73 (0, 47) passThru,

                                  NRPN mod4src_p 74 (0, 20) passThru,
                                  mrNRPN mod4amt_p 75 (0, 254),
                                  NRPN mod4dst_p 76 (0, 47) passThru,

                                  NRPN seq1dst_p 77 (0, 47) passThru,
                                  NRPN seq2dst_p 78 (0, 47) passThru,
                                  NRPN seq3dst_p 79 (0, 47) passThru,
                                  NRPN seq4dst_p 80 (0, 47) passThru,

                                  mrNRPN mwhl_p 81 (0, 254),
                                  NRPN mwhldst_p 82 (0, 47) passThru,

                                  mrNRPN aftt_p 83 (0, 254),
                                  NRPN afttdst_p 84 (0, 47) passThru,

                                  mrNRPN breath_p 85 (0, 254),
                                  NRPN breathdst_p 86 (0, 47) passThru,

                                  mrNRPN mvel_p 87 (0, 254),
                                  NRPN mveldst_p 88 (0, 47) passThru,

                                  mrNRPN foot_p 89 (0, 254),
                                  NRPN footdst_p 90 (0, 47) passThru,

                                  NRPN kbpm_p 91 (30, 250) passThru,
                                  NRPN clockdiv_p 92 (0, 12) passThru, -- TODO: document values

                                  NRPN bendrng_p 93 (0, 12) passThru,

                                  NRPN sqntrig_p 94 (0, 4) passThru, -- TODO: document values
                                  NRPN unisonkey_p 95 (0, 5) passThru, -- TODO: document values
                                  NRPN unisonmode_p 96 (0, 4) passThru, -- TODO: document values
                                  NRPN arpmode_p 97 (0, 14) passThru,

                                  NRPN erepeat_p 98 (0, 1) passThru,
                                  NRPN unison_p 99 (0, 1) passThru,


                                  NRPN arp_p 100 (0, 1) passThru,
                                  NRPN sqn_p 101 (0, 1) passThru,

                                  NRPN mcr1_p 105 (0, 183) passThru,
                                  NRPN mcr2_p 106 (0, 183) passThru,
                                  NRPN mcr3_p 107 (0, 183) passThru,
                                  NRPN mcr4_p 108 (0, 183) passThru,

                                  
                                  mNRPN shape_p 110,

                                  mrNRPN btnfreq_p 111 (0, 127),
                                  mrNRPN btnvel_p 112 (0, 127),
                                  NRPN btnmode_p 113 (0, 1) passThru,

                                  mNRPN pitch1_p 114,
                                  mNRPN pitch2_p 115,

                                  mNRPN fbvol_p 116,

                                  -- left out: editor byte,

                                  mrNRPN ksplitpoint_p 118 (0, 127),
                                  -- each patch has layer a/b
                                  NRPN kmode_p 119 (0, 2) passThru, -- 0: normal, 1: stack, both layers respond to full key range, 2: split at ksplitpoint
                                  mCC notesoff_p 123,
                                  mCC ccreset_p 121,
                                  mCC damp_p 64

                          ] ++ makeSeqTracks,
                         latency = 0.2
                       }

tetra = toShape tetraController

(notesoff, notesoff_p) = pF "notesoff" (Just 0)
(ccreset, ccreset_p) = pF "ccreset" (Just 0)
(damp, damp_p) = pF "damp" (Just (-1))


(osc1freq, osc1freq_p)      = pF "osc1freq" (Just 0.2)
(osc1detune, osc1detune_p)      = pF "osc1detune" (Just 0.5)
(osc1shape, osc1shape_p)     = pI "osc1shape" (Just 1)
(osc1glide, osc1glide_p)     = pF "osc1glide" (Just 0)
(osc1kbd, osc1kbd_p)     = pI "osc1kbd" (Just 1)

(osc2freq, osc2freq_p)      = pF "osc2freq" (Just 0.2)
(osc2detune, osc2detune_p)      = pF "osc2detune" (Just 0.5)
(osc2shape, osc2shape_p)     = pI "osc2shape" (Just 1)
(osc2glide, osc2glide_p)     = pF "osc2glide" (Just 0)
(osc2kbd, osc2kbd_p)     = pI "osc2kbd" (Just 1)

(oscsync, oscsync_p)     = pF "oscsync" (Just 0)
(glidemode, glidemode_p)     = pI "glidemode" (Just 0)
(oscslop, oscslop_p)     = pF "oscslop" (Just 0)
(oscmix, oscmix_p)      = pF "oscmix" (Just 0.5)

(noise, noise_p)     = pF "noise" (Just 0)

(kamt, kamt_p)      = pF "kamt" (Just 0.5)

(_, cutoff_p') = pF "cutoff" (Just 1)
(_, attack_p') = pF "attack" (Just 0.12)
(_, release_p') = pF "release" (Just 0.01)
(_, decay_p') = pF "decay" (Just 0.5)
(_, sustain_p') = pF "sustain" (Just 0.5)

(audiomod, audiomod_p)      = pF "audiomod" (Just 0)
(fpoles, fpoles_p)      = pI "fpoles" (Just 0)
twopole         = fpoles (p "0")
fourpole        = fpoles (p "1")

-- filter envelope
(famt, famt_p) = pF "famt" (Just 0.5)
(fvel, fvel_p)      = pF "fvel" (Just 0)
(fdel, fdel_p)      = pF "fdel" (Just 0)
(fatk, fatk_p)      = pF "fatk" (Just 0.01)
(fdcy, fdcy_p)      = pF "fdcy" (Just 0)
(fsus, fsus_p)      = pF "fsus" (Just 0)
(frel, frel_p)      = pF "frel" (Just 0.01)


(vcavol, vcavol_p)      = pF "vcavol" (Just 0)

(vamt, vamt_p)      = pF "vamt" (Just 1)
(vvel, vvel_p)      = pF "vvel" (Just 0)
(vdel, vdel_p)      = pF "vdel" (Just 0)

(lfo1rate, lfo1rate_p)      = pF "lfo1rate" (Just 0)
(lfo1shape, lfo1shape_p)     = pI "lfo1shape" (Just 0)
(lfo1amt, lfo1amt_p)     = pF "lfo1amt" (Just 0)
(lfo1dest, lfo1dest_p)      = pF "lfo1dest" (Just 0)
(lfo1sync, lfo1sync_p)      = pI "lfo1sync" (Just 0)

(lfo2rate, lfo2rate_p)      = pF "lfo2rate" (Just 0)
(lfo2shape, lfo2shape_p)     = pI "lfo2shape" (Just 0)
(lfo2amt, lfo2amt_p)     = pF "lfo2amt" (Just 0)
(lfo2dest, lfo2dest_p)      = pF "lfo2dest" (Just 0)
(lfo2sync, lfo2sync_p)      = pI "lfo2sync" (Just 0)

(lfo3rate, lfo3rate_p)      = pF "lfo3rate" (Just 0)
(lfo3shape, lfo3shape_p)     = pI "lfo3shape" (Just 0)
(lfo3amt, lfo3amt_p)     = pF "lfo3amt" (Just 0)
(lfo3dest, lfo3dest_p)      = pF "lfo3dest" (Just 0)
(lfo3sync, lfo3sync_p)      = pI "lfo3sync" (Just 0)

(lfo4rate, lfo4rate_p)      = pF "lfo4rate" (Just 0)
(lfo4shape, lfo4shape_p)     = pI "lfo4shape" (Just 0)
(lfo4amt, lfo4amt_p)     = pF "lfo4amt" (Just 0)
(lfo4dest, lfo4dest_p)      = pF "lfo4dest" (Just 0)
(lfo4sync, lfo4sync_p)      = pI "lfo4sync" (Just 0)

(emod, emod_p)      = pF "emod" (Just 0)
(eamt, eamt_p)      = pF "eamt" (Just 0.5)
(evel, evel_p)      = pF "evel" (Just 0)
(edel, edel_p)      = pF "edel" (Just 0)
(eatk, eatk_p)      = pF "eatk" (Just 0.01)
(edcy, edcy_p)      = pF "edcy" (Just 0)
(esus, esus_p)      = pF "esus" (Just 0)
(erel, erel_p)      = pF "erel" (Just 0.01)

(mod1src, mod1src_p)     = pF "mod1src" (Just 0)
(mod1amt, mod1amt_p)     = pF "mod1amt" (Just 0.5)
(mod1dst, mod1dst_p)     = pF "mod1dst" (Just 0)

(mod2src, mod2src_p)     = pF "mod2src" (Just 0)
(mod2amt, mod2amt_p)     = pF "mod2amt" (Just 0.5)
(mod2dst, mod2dst_p)     = pF "mod2dst" (Just 0)

(mod3src, mod3src_p)     = pF "mod3src" (Just 0)
(mod3amt, mod3amt_p)     = pF "mod3amt" (Just 0.5)
(mod3dst, mod3dst_p)     = pF "mod3dst" (Just 0)

(mod4src, mod4src_p)     = pF "mod4src" (Just 0)
(mod4amt, mod4amt_p)     = pF "mod4amt" (Just 0.5)
(mod4dst, mod4dst_p)     = pF "mod4dst" (Just 0)

(seq1dst, seq1dst_p)     = pF "seq1dst" (Just 0)
(seq2dst, seq2dst_p)     = pF "seq2dst" (Just 0)
(seq3dst, seq3dst_p)     = pF "seq3dst" (Just 0)
(seq4dst, seq4dst_p)     = pF "seq4dst" (Just 0)


(mwhl, mwhl_p)    = pF "mwhl" (Just 0.5)
(mwhldst, mwhldst_p) = pI "mwhldst" (Just 0)

(aftt, aftt_p)    = pF "aftt" (Just 0.5)
(afttdst, afttdst_p) = pI "afttdst" (Just 0)

(breath, breath_p)    = pF "breath" (Just 0.5)
(breathdst, breathdst_p) = pI "breathdst" (Just 0)

(mvel, mvel_p)    = pF "mvel" (Just 0.5)
(mveldst, mveldst_p) = pI "mveldst" (Just 0)

(foot, foot_p)    = pF "foot" (Just 0.5)
(footdst, footdst_p) = pI "footdst" (Just 0)

(bendrng, bendrng_p) = pI "bendrng" (Just 0)

-- left out: modwheel, breath, footctrl, pressure, velocity

(kbpm, kbpm_p)      = pI "kbpm" (Just 0)
(clockdiv, clockdiv_p)      = pI "clockdiv" (Just 0)

-- left out: pitchbend range

(sqntrig, sqntrig_p)     = pF "sqntrig" (Just 0)
(unisonkey, unisonkey_p)     = pF "unisonkey" (Just 0)
(unisonmode, unisonmode_p)      = pF "unisonmode" (Just 0)
(arpmode, arpmode_p)     = pF "arpmode" (Just 0)

(erepeat, erepeat_p)     = pF "erepeat" (Just 0)
(unison, unison_p)      = pF "unison" (Just 0)


(arp, arp_p)     = pF "arp" (Just 0)
(sqn, sqn_p)     = pF "sqn" (Just 0)

(mcr1, mcr1_p)      = pI "mcr1" (Just 0)
(mcr2, mcr2_p)      = pI "mcr2" (Just 0)
(mcr3, mcr3_p)      = pI "mcr3" (Just 0)
(mcr4, mcr4_p)      = pI "mcr4" (Just 0)

(btnfreq, btnfreq_p)     = pF "btnfreq" (Just 0.25)
(btnvel, btnvel_p)      = pF "btnvel" (Just 1)
(btnmode, btnmode_p)     = pF "btnmode" (Just 0)

(sub1vol, sub1vol_p)     = pF "sub1vol" (Just 0)
(sub2vol, sub2vol_p)     = pF "sub2vol" (Just 0)

(fbvol, fbvol_p)     = pF "fbvol" (Just 0)

(ksplitpoint, ksplitpoint_p)     = pF "ksplitpoint" (Just 0.5)
(kmode, kmode_p)     = pF "kmode" (Just 0)
knormal         = kmode (p "0")
kstack          = kmode (p "0.5")
ksplit          = kmode (p "1")


-- abstractions

-- adsr

atk3 = grp [attack_p, fatk_p, eatk_p]
dcy3 = grp [decay_p, fdcy_p, edcy_p]
sus3 = grp [sustain_p, fsus_p, esus_p]
rel3' = grp [release_p, frel_p, erel_p]

-- lfo

lfotri = doublePattern 0
lforsaw = doublePattern 1
lfosaw = doublePattern 2
lfopulse = doublePattern 3
lforand = doublePattern 4

lrate r = min 150 . max 0 <$> p r
lstep s = min 166 . max 151 . (+150) <$> p s

lfo1 s d r a = lfo1shape s |+| lfo1dest d |+| lfo1rate r |+| lfo1amt a
lfo2 s d r a = lfo2shape s |+| lfo2dest d |+| lfo2rate r |+| lfo2amt a
lfo3 s d r a = lfo3shape s |+| lfo3dest d |+| lfo3rate r |+| lfo3amt a
lfo4 s d r a = lfo4shape s |+| lfo4dest d |+| lfo4rate r |+| lfo4amt a

--lfo = lfo1

-- mod

mod1 s d a = mod1src s |+| mod1dst d |+| mod1amt a
mod2 s d a = mod2src s |+| mod2dst d |+| mod2amt a
mod3 s d a = mod3src s |+| mod3dst d |+| mod3amt a
mod4 s d a = mod4src s |+| mod4dst d |+| mod4amt a

-- mod destination

doublePattern d = (p $ show d) :: Pattern Double

dosc1 = doublePattern 1
dosc2 = doublePattern 2
dosc = doublePattern 3
dmix = doublePattern 4
dnoise = doublePattern 5
dpw1 = doublePattern 6
dpw2 = doublePattern 7
dpw = doublePattern 8
dcut = doublePattern 9
dres = doublePattern 10
damod = doublePattern 11
dvca = doublePattern 12
dspread = doublePattern 13

dlfo1f = doublePattern 14
dlfo2f = doublePattern 15
dlfo3f = doublePattern 16
dlfo4f = doublePattern 17
dlfof = doublePattern 18

dlfo1a = doublePattern 19
dlfo2a = doublePattern 20
dlfo3a = doublePattern 21
dlfo4a = doublePattern 22
dlfoa = doublePattern 23
dfamt = doublePattern 24
dvamt = doublePattern 25
deamt = doublePattern 26
damt = doublePattern 27

dfatk = doublePattern 28
dvatk = doublePattern 29
deatk = doublePattern 30
datk = doublePattern 31

dfdcy = doublePattern 32
dvdcy = doublePattern 33
dedcy = doublePattern 34
ddcy = doublePattern 35

dfrel = doublePattern 36
dvrel = doublePattern 37
derel = doublePattern 38
drel = doublePattern 39

dmod1 = doublePattern 40
dmod2 = doublePattern 41
dmod3 = doublePattern 42
dmod4 = doublePattern 43

dfb = doublePattern 44
dsub1 = doublePattern 45
dsub2 = doublePattern 46
dshape = doublePattern 47
dslew = doublePattern 48

-- mod sources

sseq1 = doublePattern 1
sseq2 = doublePattern 2
sseq3 = doublePattern 3
sseq4 = doublePattern 4
slfo1 = doublePattern 5
slfo2 = doublePattern 6
slfo3 = doublePattern 7
slfo4 = doublePattern 8

sfenv = doublePattern 9
svenv = doublePattern 10
seenv = doublePattern 11

spitchb = doublePattern 12
smodwh = doublePattern 13
saftert = doublePattern 14
sbreath = doublePattern 15
sfoot = doublePattern 16
sexpr = doublePattern 17

svel = doublePattern 18
snote = doublePattern 19
snoise = doublePattern 20
-- drums

snare = fourpole |=| osc1shape (p "0") |+| osc1kbd (p "0")
  |+| osc2shape (p "0") |+| osc2kbd (p "0")
  |+| noise (p "1")
  |+| shape (p "0.7")
  |+| fbvol (p "0.3")
  |=| resonance (p "0.2")
  |+| release (p "0.3") |+| sustain (p "0") |+| decay (p "0.3")
  |+| cutoff (p "1")
  |+| dur (p "0.02")


kick = fourpole
  |+| osc1shape (p "0") |+| osc1kbd (p "0")
  |+| osc2shape (p "0") |+| osc2kbd (p "0")
  |+| sustain (p "0") |+| decay (p "0.95") |+| release (p "0.5")
  |+| resonance (p "0.99") |+| cutoff (p "0.001")
  |+| eamt (p "0.8") |+| emod (p "9") |+| edcy (p "0.2")