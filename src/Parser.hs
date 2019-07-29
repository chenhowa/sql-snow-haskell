{-# OPTIONS_GHC -w #-}
module Parser 
    ( parse

    ) where

import Parser.Syntax as S
import Lexer.Tokens as T
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn 
	= HappyTerminal (Tok)
	| HappyErrorToken Int
	| HappyAbsSyn4 (S.Query)
	| HappyAbsSyn6 (S.Query -> S.Query -> S.Query)
	| HappyAbsSyn8 (S.Alias)
	| HappyAbsSyn9 (S.PrimitiveType)
	| HappyAbsSyn15 (S.Expr)
	| HappyAbsSyn16 (S.Args)
	| HappyAbsSyn17 (S.Arg)
	| HappyAbsSyn18 (S.OperatorType)
	| HappyAbsSyn19 (S.SelectType)
	| HappyAbsSyn20 ([ S.Column ])
	| HappyAbsSyn21 (S.Column)
	| HappyAbsSyn22 (S.FromClause)
	| HappyAbsSyn23 ([ S.Table ])
	| HappyAbsSyn24 (S.Table)
	| HappyAbsSyn25 (S.JoinType)
	| HappyAbsSyn26 (Maybe S.OnColumns)
	| HappyAbsSyn27 (Maybe S.Limit)
	| HappyAbsSyn28 (Maybe S.Where)
	| HappyAbsSyn31 (Maybe S.GroupBy)
	| HappyAbsSyn32 ([ String ])
	| HappyAbsSyn33 (S.Having)
	| HappyAbsSyn34 (Maybe S.OrderBy)
	| HappyAbsSyn35 (S.Direction)

{- to allow type-synonyms as our monads (likely
 - with explicitly-specified bind and return)
 - in Haskell98, it seems that with
 - /type M a = .../, then /(HappyReduction M)/
 - is not allowed.  But Happy is a
 - code-generator that can just substitute it.
type HappyReduction m = 
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> m HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> m HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> m HappyAbsSyn
-}

action_0,
 action_1,
 action_2,
 action_3,
 action_4,
 action_5,
 action_6,
 action_7,
 action_8,
 action_9,
 action_10,
 action_11,
 action_12,
 action_13,
 action_14,
 action_15,
 action_16,
 action_17,
 action_18,
 action_19,
 action_20,
 action_21,
 action_22,
 action_23,
 action_24,
 action_25,
 action_26,
 action_27,
 action_28,
 action_29,
 action_30,
 action_31,
 action_32,
 action_33,
 action_34,
 action_35,
 action_36,
 action_37,
 action_38,
 action_39,
 action_40,
 action_41,
 action_42,
 action_43,
 action_44,
 action_45,
 action_46,
 action_47,
 action_48,
 action_49,
 action_50,
 action_51,
 action_52,
 action_53,
 action_54,
 action_55,
 action_56,
 action_57,
 action_58,
 action_59,
 action_60,
 action_61,
 action_62,
 action_63,
 action_64,
 action_65,
 action_66,
 action_67,
 action_68,
 action_69,
 action_70,
 action_71,
 action_72,
 action_73,
 action_74,
 action_75,
 action_76,
 action_77,
 action_78,
 action_79,
 action_80,
 action_81,
 action_82,
 action_83,
 action_84,
 action_85,
 action_86,
 action_87,
 action_88,
 action_89,
 action_90,
 action_91,
 action_92,
 action_93,
 action_94,
 action_95,
 action_96,
 action_97,
 action_98,
 action_99,
 action_100,
 action_101,
 action_102,
 action_103,
 action_104,
 action_105,
 action_106,
 action_107,
 action_108,
 action_109,
 action_110,
 action_111,
 action_112,
 action_113,
 action_114,
 action_115,
 action_116,
 action_117,
 action_118,
 action_119,
 action_120,
 action_121,
 action_122,
 action_123,
 action_124,
 action_125,
 action_126,
 action_127,
 action_128,
 action_129,
 action_130,
 action_131,
 action_132,
 action_133,
 action_134,
 action_135,
 action_136,
 action_137,
 action_138,
 action_139,
 action_140,
 action_141,
 action_142,
 action_143,
 action_144,
 action_145,
 action_146,
 action_147,
 action_148,
 action_149,
 action_150,
 action_151,
 action_152,
 action_153,
 action_154,
 action_155,
 action_156,
 action_157,
 action_158,
 action_159,
 action_160,
 action_161,
 action_162,
 action_163,
 action_164,
 action_165,
 action_166,
 action_167,
 action_168,
 action_169,
 action_170,
 action_171,
 action_172,
 action_173,
 action_174,
 action_175,
 action_176,
 action_177,
 action_178,
 action_179,
 action_180,
 action_181,
 action_182,
 action_183,
 action_184,
 action_185,
 action_186,
 action_187,
 action_188,
 action_189,
 action_190,
 action_191,
 action_192,
 action_193,
 action_194,
 action_195,
 action_196,
 action_197,
 action_198,
 action_199,
 action_200,
 action_201,
 action_202,
 action_203 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyReduce_1,
 happyReduce_2,
 happyReduce_3,
 happyReduce_4,
 happyReduce_5,
 happyReduce_6,
 happyReduce_7,
 happyReduce_8,
 happyReduce_9,
 happyReduce_10,
 happyReduce_11,
 happyReduce_12,
 happyReduce_13,
 happyReduce_14,
 happyReduce_15,
 happyReduce_16,
 happyReduce_17,
 happyReduce_18,
 happyReduce_19,
 happyReduce_20,
 happyReduce_21,
 happyReduce_22,
 happyReduce_23,
 happyReduce_24,
 happyReduce_25,
 happyReduce_26,
 happyReduce_27,
 happyReduce_28,
 happyReduce_29,
 happyReduce_30,
 happyReduce_31,
 happyReduce_32,
 happyReduce_33,
 happyReduce_34,
 happyReduce_35,
 happyReduce_36,
 happyReduce_37,
 happyReduce_38,
 happyReduce_39,
 happyReduce_40,
 happyReduce_41,
 happyReduce_42,
 happyReduce_43,
 happyReduce_44,
 happyReduce_45,
 happyReduce_46,
 happyReduce_47,
 happyReduce_48,
 happyReduce_49,
 happyReduce_50,
 happyReduce_51,
 happyReduce_52,
 happyReduce_53,
 happyReduce_54,
 happyReduce_55,
 happyReduce_56,
 happyReduce_57,
 happyReduce_58,
 happyReduce_59,
 happyReduce_60,
 happyReduce_61,
 happyReduce_62,
 happyReduce_63,
 happyReduce_64,
 happyReduce_65,
 happyReduce_66,
 happyReduce_67,
 happyReduce_68,
 happyReduce_69,
 happyReduce_70,
 happyReduce_71,
 happyReduce_72,
 happyReduce_73,
 happyReduce_74,
 happyReduce_75,
 happyReduce_76,
 happyReduce_77,
 happyReduce_78,
 happyReduce_79,
 happyReduce_80,
 happyReduce_81,
 happyReduce_82,
 happyReduce_83,
 happyReduce_84,
 happyReduce_85,
 happyReduce_86,
 happyReduce_87,
 happyReduce_88,
 happyReduce_89,
 happyReduce_90,
 happyReduce_91,
 happyReduce_92,
 happyReduce_93,
 happyReduce_94,
 happyReduce_95,
 happyReduce_96,
 happyReduce_97,
 happyReduce_98,
 happyReduce_99,
 happyReduce_100,
 happyReduce_101,
 happyReduce_102,
 happyReduce_103,
 happyReduce_104,
 happyReduce_105,
 happyReduce_106,
 happyReduce_107,
 happyReduce_108,
 happyReduce_109,
 happyReduce_110,
 happyReduce_111,
 happyReduce_112,
 happyReduce_113,
 happyReduce_114,
 happyReduce_115 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,795) ([0,0,8,0,2048,0,0,0,0,0,4,0,0,2,0,512,0,0,0,0,0,0,0,0,6144,0,0,0,0,8192,32768,25089,508,0,8192,0,0,32,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,57344,7935,0,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,16,0,0,0,0,0,0,0,0,0,34822,2033,0,0,0,256,63684,3,0,0,0,0,0,0,0,0,64,65073,0,0,0,0,4096,0,0,0,0,16400,16268,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,4,0,0,33024,0,0,0,0,32768,64,0,0,0,0,0,0,256,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,256,0,0,0,0,0,0,0,0,0,65472,141,0,0,0,16384,12544,254,0,0,0,32752,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,1024,58128,15,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,0,0,64,65073,0,0,0,8192,6272,127,0,0,0,16400,16268,0,0,0,2048,50720,31,0,0,0,4100,4067,0,0,0,512,61832,7,0,0,0,50177,1016,0,0,0,128,64610,1,0,0,16384,12544,254,0,0,0,32800,32536,0,0,0,4096,35904,63,0,0,0,8200,8134,0,0,0,1024,58128,15,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,383,0,0,0,0,16376,0,0,0,0,31744,0,0,0,0,0,62,0,0,0,0,7936,0,0,0,0,32768,15,0,0,0,0,1984,0,0,0,0,57344,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,14336,0,0,0,0,0,28,0,0,0,2,0,512,0,0,0,3968,0,0,0,0,0,0,24,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64512,223,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4096,35904,63,0,0,0,0,0,0,0,0,0,256,0,0,0,16384,0,0,0,0,0,32,0,0,0,0,4096,0,0,0,0,0,8,0,0,0,0,1024,0,0,0,16384,0,0,0,0,0,0,2055,50720,31,0,0,0,0,1,0,0,0,62,0,0,0,0,0,0,0,0,0,24,65472,13,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,2048,0,0,0,0,0,4,0,0,32768,1027,58128,15,0,0,448,34818,2033,0,0,0,0,128,0,0,0,32880,25088,508,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,132,0,0,0,0,512,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,6080,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,66,0,0,0,0,0,0,0,4096,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,32,0,0,0,0,0,0,2048,1,0,0,3,49144,17,0,0,0,2048,50720,31,0,0,0,4094,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,0,2048,0,0,0,1792,8200,8134,0,0,32768,1027,58128,15,0,0,448,34818,2033,0,0,57344,256,63684,3,0,0,32880,25088,508,0,0,14336,64,65073,0,0,0,8220,6272,127,0,0,3584,16400,16268,0,0,0,2055,50720,31,0,0,896,4100,4067,0,0,49152,513,61832,7,0,0,224,50177,1016,0,0,28672,128,64610,1,0,0,57344,767,0,0,0,0,32752,0,0,0,0,63488,0,0,0,0,0,124,0,0,0,0,15872,0,0,0,0,0,31,0,0,0,0,3968,0,0,0,0,49152,7,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,28672,0,0,0,0,0,56,0,0,0,1,512,61832,7,0,128,0,50177,1016,0,0,0,0,384,0,0,0,0,0,0,0,0,192,0,64,0,0,0,0,0,0,0,0,0,0,128,0,0,0,0,0,0,0,0,0,34818,2033,0,0,0,0,2112,0,0,0,0,8,0,0,0,0,1024,0,0,0,0,0,0,1,0,0,0,0,4,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65280,55,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,3072,0,0,256,0,34818,2033,0,0,0,0,256,0,0,0,0,32768,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","SubQuery","Union","Intersect","Alias","Null","True","False","String","Number","Primitive","Expr","Args","Arg","Operator","SType","Columns","Column","From","Tables","Table","Join","On","Limit","Where","WhereExpr","WhereOperator","GroupBy","ColNames","Having","OrderBy","Direction","select","from","where","groupBy","having","in","notIn","distinct","limit","orderBy","ascending","descending","union","intersect","all","exists","any","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","'('","')'","','","bc","dotwalk","integer","float","string","true","false","null","%eof"]
        bit_start = st * 87
        bit_end = (st + 1) * 87
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..86]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (36) = happyShift action_5
action_0 (76) = happyShift action_6
action_0 (4) = happyGoto action_3
action_0 (5) = happyGoto action_4
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (76) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (36) = happyShift action_5
action_2 (76) = happyShift action_6
action_2 (4) = happyGoto action_36
action_2 (5) = happyGoto action_4
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (87) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (48) = happyShift action_34
action_4 (49) = happyShift action_35
action_4 (6) = happyGoto action_32
action_4 (7) = happyGoto action_33
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (43) = happyShift action_19
action_5 (61) = happyShift action_20
action_5 (62) = happyShift action_21
action_5 (71) = happyShift action_22
action_5 (75) = happyShift action_23
action_5 (76) = happyShift action_24
action_5 (80) = happyShift action_25
action_5 (81) = happyShift action_26
action_5 (82) = happyShift action_27
action_5 (83) = happyShift action_28
action_5 (84) = happyShift action_29
action_5 (85) = happyShift action_30
action_5 (86) = happyShift action_31
action_5 (9) = happyGoto action_8
action_5 (10) = happyGoto action_9
action_5 (11) = happyGoto action_10
action_5 (12) = happyGoto action_11
action_5 (13) = happyGoto action_12
action_5 (14) = happyGoto action_13
action_5 (15) = happyGoto action_14
action_5 (18) = happyGoto action_15
action_5 (19) = happyGoto action_16
action_5 (20) = happyGoto action_17
action_5 (21) = happyGoto action_18
action_5 _ = happyFail (happyExpListPerState 5)

action_6 (36) = happyShift action_5
action_6 (76) = happyShift action_6
action_6 (4) = happyGoto action_7
action_6 (5) = happyGoto action_4
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (77) = happyShift action_69
action_7 _ = happyFail (happyExpListPerState 7)

action_8 _ = happyReduce_23

action_9 _ = happyReduce_24

action_10 _ = happyReduce_25

action_11 _ = happyReduce_26

action_12 _ = happyReduce_27

action_13 _ = happyReduce_28

action_14 (60) = happyShift action_54
action_14 (61) = happyShift action_55
action_14 (62) = happyShift action_56
action_14 (63) = happyShift action_57
action_14 (64) = happyShift action_58
action_14 (65) = happyShift action_59
action_14 (66) = happyShift action_60
action_14 (67) = happyShift action_61
action_14 (68) = happyShift action_62
action_14 (69) = happyShift action_63
action_14 (70) = happyShift action_64
action_14 (72) = happyShift action_65
action_14 (73) = happyShift action_66
action_14 (74) = happyShift action_67
action_14 (75) = happyShift action_68
action_14 (8) = happyGoto action_53
action_14 _ = happyReduce_56

action_15 _ = happyReduce_32

action_16 (37) = happyShift action_52
action_16 (22) = happyGoto action_51
action_16 _ = happyReduce_2

action_17 (78) = happyShift action_50
action_17 _ = happyReduce_53

action_18 _ = happyReduce_54

action_19 (61) = happyShift action_20
action_19 (62) = happyShift action_21
action_19 (71) = happyShift action_22
action_19 (75) = happyShift action_23
action_19 (76) = happyShift action_24
action_19 (80) = happyShift action_25
action_19 (81) = happyShift action_26
action_19 (82) = happyShift action_27
action_19 (83) = happyShift action_28
action_19 (84) = happyShift action_29
action_19 (85) = happyShift action_30
action_19 (86) = happyShift action_31
action_19 (9) = happyGoto action_8
action_19 (10) = happyGoto action_9
action_19 (11) = happyGoto action_10
action_19 (12) = happyGoto action_11
action_19 (13) = happyGoto action_12
action_19 (14) = happyGoto action_13
action_19 (15) = happyGoto action_14
action_19 (18) = happyGoto action_15
action_19 (19) = happyGoto action_49
action_19 (20) = happyGoto action_17
action_19 (21) = happyGoto action_18
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (61) = happyShift action_20
action_20 (71) = happyShift action_22
action_20 (75) = happyShift action_23
action_20 (76) = happyShift action_24
action_20 (80) = happyShift action_25
action_20 (81) = happyShift action_26
action_20 (82) = happyShift action_27
action_20 (83) = happyShift action_28
action_20 (84) = happyShift action_29
action_20 (85) = happyShift action_30
action_20 (86) = happyShift action_31
action_20 (9) = happyGoto action_8
action_20 (10) = happyGoto action_9
action_20 (11) = happyGoto action_10
action_20 (12) = happyGoto action_11
action_20 (13) = happyGoto action_12
action_20 (14) = happyGoto action_13
action_20 (15) = happyGoto action_48
action_20 (18) = happyGoto action_15
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_52

action_22 (61) = happyShift action_20
action_22 (71) = happyShift action_22
action_22 (75) = happyShift action_23
action_22 (76) = happyShift action_24
action_22 (80) = happyShift action_25
action_22 (81) = happyShift action_26
action_22 (82) = happyShift action_27
action_22 (83) = happyShift action_28
action_22 (84) = happyShift action_29
action_22 (85) = happyShift action_30
action_22 (86) = happyShift action_31
action_22 (9) = happyGoto action_8
action_22 (10) = happyGoto action_9
action_22 (11) = happyGoto action_10
action_22 (12) = happyGoto action_11
action_22 (13) = happyGoto action_12
action_22 (14) = happyGoto action_13
action_22 (15) = happyGoto action_47
action_22 (18) = happyGoto action_15
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (76) = happyShift action_46
action_23 _ = happyReduce_29

action_24 (61) = happyShift action_20
action_24 (71) = happyShift action_22
action_24 (75) = happyShift action_23
action_24 (76) = happyShift action_24
action_24 (80) = happyShift action_25
action_24 (81) = happyShift action_26
action_24 (82) = happyShift action_27
action_24 (83) = happyShift action_28
action_24 (84) = happyShift action_29
action_24 (85) = happyShift action_30
action_24 (86) = happyShift action_31
action_24 (9) = happyGoto action_8
action_24 (10) = happyGoto action_9
action_24 (11) = happyGoto action_10
action_24 (12) = happyGoto action_11
action_24 (13) = happyGoto action_12
action_24 (14) = happyGoto action_13
action_24 (15) = happyGoto action_45
action_24 (18) = happyGoto action_15
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_30

action_26 _ = happyReduce_21

action_27 _ = happyReduce_22

action_28 _ = happyReduce_20

action_29 _ = happyReduce_18

action_30 _ = happyReduce_19

action_31 _ = happyReduce_17

action_32 (76) = happyShift action_43
action_32 (5) = happyGoto action_44
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (76) = happyShift action_43
action_33 (5) = happyGoto action_42
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (43) = happyShift action_40
action_34 (50) = happyShift action_41
action_34 _ = happyReduce_9

action_35 (43) = happyShift action_38
action_35 (50) = happyShift action_39
action_35 _ = happyReduce_12

action_36 (77) = happyShift action_37
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_14

action_39 _ = happyReduce_13

action_40 _ = happyReduce_11

action_41 _ = happyReduce_10

action_42 _ = happyReduce_7

action_43 (36) = happyShift action_5
action_43 (76) = happyShift action_6
action_43 (4) = happyGoto action_93
action_43 (5) = happyGoto action_4
action_43 _ = happyFail (happyExpListPerState 43)

action_44 _ = happyReduce_6

action_45 (60) = happyShift action_54
action_45 (61) = happyShift action_55
action_45 (62) = happyShift action_56
action_45 (63) = happyShift action_57
action_45 (64) = happyShift action_58
action_45 (65) = happyShift action_59
action_45 (66) = happyShift action_60
action_45 (67) = happyShift action_61
action_45 (68) = happyShift action_62
action_45 (69) = happyShift action_63
action_45 (70) = happyShift action_64
action_45 (72) = happyShift action_65
action_45 (73) = happyShift action_66
action_45 (77) = happyShift action_92
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (61) = happyShift action_20
action_46 (71) = happyShift action_22
action_46 (75) = happyShift action_23
action_46 (76) = happyShift action_24
action_46 (80) = happyShift action_25
action_46 (81) = happyShift action_26
action_46 (82) = happyShift action_27
action_46 (83) = happyShift action_28
action_46 (84) = happyShift action_29
action_46 (85) = happyShift action_30
action_46 (86) = happyShift action_31
action_46 (9) = happyGoto action_8
action_46 (10) = happyGoto action_9
action_46 (11) = happyGoto action_10
action_46 (12) = happyGoto action_11
action_46 (13) = happyGoto action_12
action_46 (14) = happyGoto action_13
action_46 (15) = happyGoto action_89
action_46 (16) = happyGoto action_90
action_46 (17) = happyGoto action_91
action_46 (18) = happyGoto action_15
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (60) = happyShift action_54
action_47 (61) = happyShift action_55
action_47 (62) = happyShift action_56
action_47 (63) = happyShift action_57
action_47 (64) = happyShift action_58
action_47 (65) = happyShift action_59
action_47 (66) = happyShift action_60
action_47 (67) = happyShift action_61
action_47 (68) = happyShift action_62
action_47 (69) = happyShift action_63
action_47 (70) = happyShift action_64
action_47 _ = happyReduce_50

action_48 _ = happyReduce_51

action_49 (37) = happyShift action_52
action_49 (22) = happyGoto action_88
action_49 _ = happyReduce_4

action_50 (61) = happyShift action_20
action_50 (71) = happyShift action_22
action_50 (75) = happyShift action_23
action_50 (76) = happyShift action_24
action_50 (80) = happyShift action_25
action_50 (81) = happyShift action_26
action_50 (82) = happyShift action_27
action_50 (83) = happyShift action_28
action_50 (84) = happyShift action_29
action_50 (85) = happyShift action_30
action_50 (86) = happyShift action_31
action_50 (9) = happyGoto action_8
action_50 (10) = happyGoto action_9
action_50 (11) = happyGoto action_10
action_50 (12) = happyGoto action_11
action_50 (13) = happyGoto action_12
action_50 (14) = happyGoto action_13
action_50 (15) = happyGoto action_14
action_50 (18) = happyGoto action_15
action_50 (21) = happyGoto action_87
action_50 _ = happyFail (happyExpListPerState 50)

action_51 _ = happyReduce_3

action_52 (75) = happyShift action_86
action_52 (23) = happyGoto action_84
action_52 (24) = happyGoto action_85
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_57

action_54 (61) = happyShift action_20
action_54 (71) = happyShift action_22
action_54 (75) = happyShift action_23
action_54 (76) = happyShift action_24
action_54 (80) = happyShift action_25
action_54 (81) = happyShift action_26
action_54 (82) = happyShift action_27
action_54 (83) = happyShift action_28
action_54 (84) = happyShift action_29
action_54 (85) = happyShift action_30
action_54 (86) = happyShift action_31
action_54 (9) = happyGoto action_8
action_54 (10) = happyGoto action_9
action_54 (11) = happyGoto action_10
action_54 (12) = happyGoto action_11
action_54 (13) = happyGoto action_12
action_54 (14) = happyGoto action_13
action_54 (15) = happyGoto action_83
action_54 (18) = happyGoto action_15
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (61) = happyShift action_20
action_55 (71) = happyShift action_22
action_55 (75) = happyShift action_23
action_55 (76) = happyShift action_24
action_55 (80) = happyShift action_25
action_55 (81) = happyShift action_26
action_55 (82) = happyShift action_27
action_55 (83) = happyShift action_28
action_55 (84) = happyShift action_29
action_55 (85) = happyShift action_30
action_55 (86) = happyShift action_31
action_55 (9) = happyGoto action_8
action_55 (10) = happyGoto action_9
action_55 (11) = happyGoto action_10
action_55 (12) = happyGoto action_11
action_55 (13) = happyGoto action_12
action_55 (14) = happyGoto action_13
action_55 (15) = happyGoto action_82
action_55 (18) = happyGoto action_15
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (61) = happyShift action_20
action_56 (71) = happyShift action_22
action_56 (75) = happyShift action_23
action_56 (76) = happyShift action_24
action_56 (80) = happyShift action_25
action_56 (81) = happyShift action_26
action_56 (82) = happyShift action_27
action_56 (83) = happyShift action_28
action_56 (84) = happyShift action_29
action_56 (85) = happyShift action_30
action_56 (86) = happyShift action_31
action_56 (9) = happyGoto action_8
action_56 (10) = happyGoto action_9
action_56 (11) = happyGoto action_10
action_56 (12) = happyGoto action_11
action_56 (13) = happyGoto action_12
action_56 (14) = happyGoto action_13
action_56 (15) = happyGoto action_81
action_56 (18) = happyGoto action_15
action_56 _ = happyFail (happyExpListPerState 56)

action_57 (61) = happyShift action_20
action_57 (71) = happyShift action_22
action_57 (75) = happyShift action_23
action_57 (76) = happyShift action_24
action_57 (80) = happyShift action_25
action_57 (81) = happyShift action_26
action_57 (82) = happyShift action_27
action_57 (83) = happyShift action_28
action_57 (84) = happyShift action_29
action_57 (85) = happyShift action_30
action_57 (86) = happyShift action_31
action_57 (9) = happyGoto action_8
action_57 (10) = happyGoto action_9
action_57 (11) = happyGoto action_10
action_57 (12) = happyGoto action_11
action_57 (13) = happyGoto action_12
action_57 (14) = happyGoto action_13
action_57 (15) = happyGoto action_80
action_57 (18) = happyGoto action_15
action_57 _ = happyFail (happyExpListPerState 57)

action_58 (61) = happyShift action_20
action_58 (71) = happyShift action_22
action_58 (75) = happyShift action_23
action_58 (76) = happyShift action_24
action_58 (80) = happyShift action_25
action_58 (81) = happyShift action_26
action_58 (82) = happyShift action_27
action_58 (83) = happyShift action_28
action_58 (84) = happyShift action_29
action_58 (85) = happyShift action_30
action_58 (86) = happyShift action_31
action_58 (9) = happyGoto action_8
action_58 (10) = happyGoto action_9
action_58 (11) = happyGoto action_10
action_58 (12) = happyGoto action_11
action_58 (13) = happyGoto action_12
action_58 (14) = happyGoto action_13
action_58 (15) = happyGoto action_79
action_58 (18) = happyGoto action_15
action_58 _ = happyFail (happyExpListPerState 58)

action_59 (61) = happyShift action_20
action_59 (71) = happyShift action_22
action_59 (75) = happyShift action_23
action_59 (76) = happyShift action_24
action_59 (80) = happyShift action_25
action_59 (81) = happyShift action_26
action_59 (82) = happyShift action_27
action_59 (83) = happyShift action_28
action_59 (84) = happyShift action_29
action_59 (85) = happyShift action_30
action_59 (86) = happyShift action_31
action_59 (9) = happyGoto action_8
action_59 (10) = happyGoto action_9
action_59 (11) = happyGoto action_10
action_59 (12) = happyGoto action_11
action_59 (13) = happyGoto action_12
action_59 (14) = happyGoto action_13
action_59 (15) = happyGoto action_78
action_59 (18) = happyGoto action_15
action_59 _ = happyFail (happyExpListPerState 59)

action_60 (61) = happyShift action_20
action_60 (71) = happyShift action_22
action_60 (75) = happyShift action_23
action_60 (76) = happyShift action_24
action_60 (80) = happyShift action_25
action_60 (81) = happyShift action_26
action_60 (82) = happyShift action_27
action_60 (83) = happyShift action_28
action_60 (84) = happyShift action_29
action_60 (85) = happyShift action_30
action_60 (86) = happyShift action_31
action_60 (9) = happyGoto action_8
action_60 (10) = happyGoto action_9
action_60 (11) = happyGoto action_10
action_60 (12) = happyGoto action_11
action_60 (13) = happyGoto action_12
action_60 (14) = happyGoto action_13
action_60 (15) = happyGoto action_77
action_60 (18) = happyGoto action_15
action_60 _ = happyFail (happyExpListPerState 60)

action_61 (61) = happyShift action_20
action_61 (71) = happyShift action_22
action_61 (75) = happyShift action_23
action_61 (76) = happyShift action_24
action_61 (80) = happyShift action_25
action_61 (81) = happyShift action_26
action_61 (82) = happyShift action_27
action_61 (83) = happyShift action_28
action_61 (84) = happyShift action_29
action_61 (85) = happyShift action_30
action_61 (86) = happyShift action_31
action_61 (9) = happyGoto action_8
action_61 (10) = happyGoto action_9
action_61 (11) = happyGoto action_10
action_61 (12) = happyGoto action_11
action_61 (13) = happyGoto action_12
action_61 (14) = happyGoto action_13
action_61 (15) = happyGoto action_76
action_61 (18) = happyGoto action_15
action_61 _ = happyFail (happyExpListPerState 61)

action_62 (61) = happyShift action_20
action_62 (71) = happyShift action_22
action_62 (75) = happyShift action_23
action_62 (76) = happyShift action_24
action_62 (80) = happyShift action_25
action_62 (81) = happyShift action_26
action_62 (82) = happyShift action_27
action_62 (83) = happyShift action_28
action_62 (84) = happyShift action_29
action_62 (85) = happyShift action_30
action_62 (86) = happyShift action_31
action_62 (9) = happyGoto action_8
action_62 (10) = happyGoto action_9
action_62 (11) = happyGoto action_10
action_62 (12) = happyGoto action_11
action_62 (13) = happyGoto action_12
action_62 (14) = happyGoto action_13
action_62 (15) = happyGoto action_75
action_62 (18) = happyGoto action_15
action_62 _ = happyFail (happyExpListPerState 62)

action_63 (61) = happyShift action_20
action_63 (71) = happyShift action_22
action_63 (75) = happyShift action_23
action_63 (76) = happyShift action_24
action_63 (80) = happyShift action_25
action_63 (81) = happyShift action_26
action_63 (82) = happyShift action_27
action_63 (83) = happyShift action_28
action_63 (84) = happyShift action_29
action_63 (85) = happyShift action_30
action_63 (86) = happyShift action_31
action_63 (9) = happyGoto action_8
action_63 (10) = happyGoto action_9
action_63 (11) = happyGoto action_10
action_63 (12) = happyGoto action_11
action_63 (13) = happyGoto action_12
action_63 (14) = happyGoto action_13
action_63 (15) = happyGoto action_74
action_63 (18) = happyGoto action_15
action_63 _ = happyFail (happyExpListPerState 63)

action_64 (61) = happyShift action_20
action_64 (71) = happyShift action_22
action_64 (75) = happyShift action_23
action_64 (76) = happyShift action_24
action_64 (80) = happyShift action_25
action_64 (81) = happyShift action_26
action_64 (82) = happyShift action_27
action_64 (83) = happyShift action_28
action_64 (84) = happyShift action_29
action_64 (85) = happyShift action_30
action_64 (86) = happyShift action_31
action_64 (9) = happyGoto action_8
action_64 (10) = happyGoto action_9
action_64 (11) = happyGoto action_10
action_64 (12) = happyGoto action_11
action_64 (13) = happyGoto action_12
action_64 (14) = happyGoto action_13
action_64 (15) = happyGoto action_73
action_64 (18) = happyGoto action_15
action_64 _ = happyFail (happyExpListPerState 64)

action_65 (61) = happyShift action_20
action_65 (71) = happyShift action_22
action_65 (75) = happyShift action_23
action_65 (76) = happyShift action_24
action_65 (80) = happyShift action_25
action_65 (81) = happyShift action_26
action_65 (82) = happyShift action_27
action_65 (83) = happyShift action_28
action_65 (84) = happyShift action_29
action_65 (85) = happyShift action_30
action_65 (86) = happyShift action_31
action_65 (9) = happyGoto action_8
action_65 (10) = happyGoto action_9
action_65 (11) = happyGoto action_10
action_65 (12) = happyGoto action_11
action_65 (13) = happyGoto action_12
action_65 (14) = happyGoto action_13
action_65 (15) = happyGoto action_72
action_65 (18) = happyGoto action_15
action_65 _ = happyFail (happyExpListPerState 65)

action_66 (61) = happyShift action_20
action_66 (71) = happyShift action_22
action_66 (75) = happyShift action_23
action_66 (76) = happyShift action_24
action_66 (80) = happyShift action_25
action_66 (81) = happyShift action_26
action_66 (82) = happyShift action_27
action_66 (83) = happyShift action_28
action_66 (84) = happyShift action_29
action_66 (85) = happyShift action_30
action_66 (86) = happyShift action_31
action_66 (9) = happyGoto action_8
action_66 (10) = happyGoto action_9
action_66 (11) = happyGoto action_10
action_66 (12) = happyGoto action_11
action_66 (13) = happyGoto action_12
action_66 (14) = happyGoto action_13
action_66 (15) = happyGoto action_71
action_66 (18) = happyGoto action_15
action_66 _ = happyFail (happyExpListPerState 66)

action_67 (75) = happyShift action_70
action_67 _ = happyFail (happyExpListPerState 67)

action_68 _ = happyReduce_15

action_69 (77) = happyReduce_1
action_69 (87) = happyReduce_1
action_69 _ = happyReduce_8

action_70 _ = happyReduce_16

action_71 (60) = happyShift action_54
action_71 (61) = happyShift action_55
action_71 (62) = happyShift action_56
action_71 (63) = happyShift action_57
action_71 (64) = happyShift action_58
action_71 (65) = happyShift action_59
action_71 (66) = happyShift action_60
action_71 (67) = happyShift action_61
action_71 (68) = happyShift action_62
action_71 (69) = happyShift action_63
action_71 (70) = happyShift action_64
action_71 (72) = happyShift action_65
action_71 _ = happyReduce_49

action_72 (60) = happyShift action_54
action_72 (61) = happyShift action_55
action_72 (62) = happyShift action_56
action_72 (63) = happyShift action_57
action_72 (64) = happyShift action_58
action_72 (65) = happyShift action_59
action_72 (66) = happyShift action_60
action_72 (67) = happyShift action_61
action_72 (68) = happyShift action_62
action_72 (69) = happyShift action_63
action_72 (70) = happyShift action_64
action_72 _ = happyReduce_48

action_73 (60) = happyShift action_54
action_73 (61) = happyShift action_55
action_73 (62) = happyShift action_56
action_73 (63) = happyShift action_57
action_73 (64) = happyShift action_58
action_73 (65) = happyFail []
action_73 (66) = happyFail []
action_73 (67) = happyFail []
action_73 (68) = happyFail []
action_73 (69) = happyFail []
action_73 (70) = happyFail []
action_73 _ = happyReduce_47

action_74 (60) = happyShift action_54
action_74 (61) = happyShift action_55
action_74 (62) = happyShift action_56
action_74 (63) = happyShift action_57
action_74 (64) = happyShift action_58
action_74 (65) = happyFail []
action_74 (66) = happyFail []
action_74 (67) = happyFail []
action_74 (68) = happyFail []
action_74 (69) = happyFail []
action_74 (70) = happyFail []
action_74 _ = happyReduce_46

action_75 (60) = happyShift action_54
action_75 (61) = happyShift action_55
action_75 (62) = happyShift action_56
action_75 (63) = happyShift action_57
action_75 (64) = happyShift action_58
action_75 (65) = happyFail []
action_75 (66) = happyFail []
action_75 (67) = happyFail []
action_75 (68) = happyFail []
action_75 (69) = happyFail []
action_75 (70) = happyFail []
action_75 _ = happyReduce_45

action_76 (60) = happyShift action_54
action_76 (61) = happyShift action_55
action_76 (62) = happyShift action_56
action_76 (63) = happyShift action_57
action_76 (64) = happyShift action_58
action_76 (65) = happyFail []
action_76 (66) = happyFail []
action_76 (67) = happyFail []
action_76 (68) = happyFail []
action_76 (69) = happyFail []
action_76 (70) = happyFail []
action_76 _ = happyReduce_44

action_77 (60) = happyShift action_54
action_77 (61) = happyShift action_55
action_77 (62) = happyShift action_56
action_77 (63) = happyShift action_57
action_77 (64) = happyShift action_58
action_77 (65) = happyFail []
action_77 (66) = happyFail []
action_77 (67) = happyFail []
action_77 (68) = happyFail []
action_77 (69) = happyFail []
action_77 (70) = happyFail []
action_77 _ = happyReduce_43

action_78 (60) = happyShift action_54
action_78 (61) = happyShift action_55
action_78 (62) = happyShift action_56
action_78 (63) = happyShift action_57
action_78 (64) = happyShift action_58
action_78 (65) = happyFail []
action_78 (66) = happyFail []
action_78 (67) = happyFail []
action_78 (68) = happyFail []
action_78 (69) = happyFail []
action_78 (70) = happyFail []
action_78 _ = happyReduce_42

action_79 _ = happyReduce_41

action_80 _ = happyReduce_40

action_81 _ = happyReduce_39

action_82 (62) = happyShift action_56
action_82 (63) = happyShift action_57
action_82 (64) = happyShift action_58
action_82 _ = happyReduce_38

action_83 (62) = happyShift action_56
action_83 (63) = happyShift action_57
action_83 (64) = happyShift action_58
action_83 _ = happyReduce_37

action_84 (38) = happyShift action_105
action_84 (78) = happyShift action_106
action_84 (28) = happyGoto action_104
action_84 _ = happyReduce_73

action_85 (53) = happyShift action_99
action_85 (54) = happyShift action_100
action_85 (55) = happyShift action_101
action_85 (56) = happyShift action_102
action_85 (57) = happyShift action_103
action_85 (25) = happyGoto action_98
action_85 _ = happyReduce_59

action_86 (74) = happyShift action_67
action_86 (75) = happyShift action_68
action_86 (8) = happyGoto action_97
action_86 _ = happyReduce_61

action_87 _ = happyReduce_55

action_88 _ = happyReduce_5

action_89 (60) = happyShift action_54
action_89 (61) = happyShift action_55
action_89 (62) = happyShift action_56
action_89 (63) = happyShift action_57
action_89 (64) = happyShift action_58
action_89 (65) = happyShift action_59
action_89 (66) = happyShift action_60
action_89 (67) = happyShift action_61
action_89 (68) = happyShift action_62
action_89 (69) = happyShift action_63
action_89 (70) = happyShift action_64
action_89 (72) = happyShift action_65
action_89 (73) = happyShift action_66
action_89 _ = happyReduce_36

action_90 (77) = happyShift action_95
action_90 (78) = happyShift action_96
action_90 _ = happyFail (happyExpListPerState 90)

action_91 _ = happyReduce_34

action_92 _ = happyReduce_33

action_93 (77) = happyShift action_94
action_93 _ = happyFail (happyExpListPerState 93)

action_94 _ = happyReduce_8

action_95 _ = happyReduce_31

action_96 (61) = happyShift action_20
action_96 (71) = happyShift action_22
action_96 (75) = happyShift action_23
action_96 (76) = happyShift action_24
action_96 (80) = happyShift action_25
action_96 (81) = happyShift action_26
action_96 (82) = happyShift action_27
action_96 (83) = happyShift action_28
action_96 (84) = happyShift action_29
action_96 (85) = happyShift action_30
action_96 (86) = happyShift action_31
action_96 (9) = happyGoto action_8
action_96 (10) = happyGoto action_9
action_96 (11) = happyGoto action_10
action_96 (12) = happyGoto action_11
action_96 (13) = happyGoto action_12
action_96 (14) = happyGoto action_13
action_96 (15) = happyGoto action_89
action_96 (17) = happyGoto action_127
action_96 (18) = happyGoto action_15
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_62

action_98 (75) = happyShift action_86
action_98 (24) = happyGoto action_126
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (58) = happyShift action_125
action_99 _ = happyFail (happyExpListPerState 99)

action_100 (58) = happyShift action_124
action_100 _ = happyFail (happyExpListPerState 100)

action_101 (58) = happyShift action_123
action_101 _ = happyFail (happyExpListPerState 101)

action_102 (58) = happyShift action_122
action_102 _ = happyFail (happyExpListPerState 102)

action_103 (58) = happyShift action_121
action_103 _ = happyFail (happyExpListPerState 103)

action_104 (39) = happyShift action_120
action_104 (31) = happyGoto action_119
action_104 _ = happyReduce_103

action_105 (50) = happyShift action_111
action_105 (51) = happyShift action_112
action_105 (52) = happyShift action_113
action_105 (61) = happyShift action_114
action_105 (71) = happyShift action_115
action_105 (75) = happyShift action_116
action_105 (76) = happyShift action_117
action_105 (80) = happyShift action_118
action_105 (81) = happyShift action_26
action_105 (82) = happyShift action_27
action_105 (83) = happyShift action_28
action_105 (84) = happyShift action_29
action_105 (85) = happyShift action_30
action_105 (86) = happyShift action_31
action_105 (9) = happyGoto action_8
action_105 (10) = happyGoto action_9
action_105 (11) = happyGoto action_10
action_105 (12) = happyGoto action_11
action_105 (13) = happyGoto action_12
action_105 (14) = happyGoto action_108
action_105 (29) = happyGoto action_109
action_105 (30) = happyGoto action_110
action_105 _ = happyFail (happyExpListPerState 105)

action_106 (75) = happyShift action_86
action_106 (24) = happyGoto action_107
action_106 _ = happyFail (happyExpListPerState 106)

action_107 (53) = happyShift action_99
action_107 (54) = happyShift action_100
action_107 (55) = happyShift action_101
action_107 (56) = happyShift action_102
action_107 (57) = happyShift action_103
action_107 (25) = happyGoto action_98
action_107 _ = happyReduce_60

action_108 _ = happyReduce_75

action_109 (41) = happyShift action_143
action_109 (42) = happyShift action_144
action_109 (60) = happyShift action_145
action_109 (61) = happyShift action_146
action_109 (62) = happyShift action_147
action_109 (63) = happyShift action_148
action_109 (64) = happyShift action_149
action_109 (65) = happyShift action_150
action_109 (66) = happyShift action_151
action_109 (67) = happyShift action_152
action_109 (68) = happyShift action_153
action_109 (69) = happyShift action_154
action_109 (70) = happyShift action_155
action_109 (72) = happyShift action_156
action_109 (73) = happyShift action_157
action_109 _ = happyReduce_74

action_110 _ = happyReduce_79

action_111 (76) = happyShift action_43
action_111 (5) = happyGoto action_142
action_111 _ = happyFail (happyExpListPerState 111)

action_112 (76) = happyShift action_43
action_112 (5) = happyGoto action_141
action_112 _ = happyFail (happyExpListPerState 112)

action_113 (76) = happyShift action_43
action_113 (5) = happyGoto action_140
action_113 _ = happyFail (happyExpListPerState 113)

action_114 (50) = happyShift action_111
action_114 (51) = happyShift action_112
action_114 (52) = happyShift action_113
action_114 (61) = happyShift action_114
action_114 (71) = happyShift action_115
action_114 (75) = happyShift action_116
action_114 (76) = happyShift action_117
action_114 (80) = happyShift action_118
action_114 (81) = happyShift action_26
action_114 (82) = happyShift action_27
action_114 (83) = happyShift action_28
action_114 (84) = happyShift action_29
action_114 (85) = happyShift action_30
action_114 (86) = happyShift action_31
action_114 (9) = happyGoto action_8
action_114 (10) = happyGoto action_9
action_114 (11) = happyGoto action_10
action_114 (12) = happyGoto action_11
action_114 (13) = happyGoto action_12
action_114 (14) = happyGoto action_108
action_114 (29) = happyGoto action_139
action_114 (30) = happyGoto action_110
action_114 _ = happyFail (happyExpListPerState 114)

action_115 (50) = happyShift action_111
action_115 (51) = happyShift action_112
action_115 (52) = happyShift action_113
action_115 (61) = happyShift action_114
action_115 (71) = happyShift action_115
action_115 (75) = happyShift action_116
action_115 (76) = happyShift action_117
action_115 (80) = happyShift action_118
action_115 (81) = happyShift action_26
action_115 (82) = happyShift action_27
action_115 (83) = happyShift action_28
action_115 (84) = happyShift action_29
action_115 (85) = happyShift action_30
action_115 (86) = happyShift action_31
action_115 (9) = happyGoto action_8
action_115 (10) = happyGoto action_9
action_115 (11) = happyGoto action_10
action_115 (12) = happyGoto action_11
action_115 (13) = happyGoto action_12
action_115 (14) = happyGoto action_108
action_115 (29) = happyGoto action_138
action_115 (30) = happyGoto action_110
action_115 _ = happyFail (happyExpListPerState 115)

action_116 (76) = happyShift action_137
action_116 _ = happyReduce_76

action_117 (50) = happyShift action_111
action_117 (51) = happyShift action_112
action_117 (52) = happyShift action_113
action_117 (61) = happyShift action_114
action_117 (71) = happyShift action_115
action_117 (75) = happyShift action_116
action_117 (76) = happyShift action_117
action_117 (80) = happyShift action_118
action_117 (81) = happyShift action_26
action_117 (82) = happyShift action_27
action_117 (83) = happyShift action_28
action_117 (84) = happyShift action_29
action_117 (85) = happyShift action_30
action_117 (86) = happyShift action_31
action_117 (9) = happyGoto action_8
action_117 (10) = happyGoto action_9
action_117 (11) = happyGoto action_10
action_117 (12) = happyGoto action_11
action_117 (13) = happyGoto action_12
action_117 (14) = happyGoto action_108
action_117 (29) = happyGoto action_136
action_117 (30) = happyGoto action_110
action_117 _ = happyFail (happyExpListPerState 117)

action_118 _ = happyReduce_77

action_119 (45) = happyShift action_135
action_119 (34) = happyGoto action_134
action_119 _ = happyReduce_111

action_120 (75) = happyShift action_132
action_120 (80) = happyShift action_133
action_120 (32) = happyGoto action_131
action_120 _ = happyFail (happyExpListPerState 120)

action_121 (75) = happyShift action_86
action_121 (24) = happyGoto action_130
action_121 _ = happyFail (happyExpListPerState 121)

action_122 _ = happyReduce_68

action_123 _ = happyReduce_65

action_124 _ = happyReduce_67

action_125 _ = happyReduce_66

action_126 (53) = happyShift action_99
action_126 (54) = happyShift action_100
action_126 (55) = happyShift action_101
action_126 (56) = happyShift action_102
action_126 (57) = happyShift action_103
action_126 (59) = happyShift action_129
action_126 (25) = happyGoto action_98
action_126 (26) = happyGoto action_128
action_126 _ = happyFail (happyExpListPerState 126)

action_127 _ = happyReduce_35

action_128 _ = happyReduce_64

action_129 (75) = happyShift action_181
action_129 (80) = happyShift action_182
action_129 _ = happyFail (happyExpListPerState 129)

action_130 (53) = happyShift action_99
action_130 (54) = happyShift action_100
action_130 (55) = happyShift action_101
action_130 (56) = happyShift action_102
action_130 (57) = happyShift action_103
action_130 (25) = happyGoto action_98
action_130 _ = happyReduce_63

action_131 (40) = happyShift action_179
action_131 (78) = happyShift action_180
action_131 (33) = happyGoto action_178
action_131 _ = happyReduce_104

action_132 _ = happyReduce_106

action_133 _ = happyReduce_107

action_134 (44) = happyShift action_177
action_134 (27) = happyGoto action_176
action_134 _ = happyReduce_71

action_135 (75) = happyShift action_132
action_135 (80) = happyShift action_133
action_135 (32) = happyGoto action_175
action_135 _ = happyFail (happyExpListPerState 135)

action_136 (41) = happyShift action_143
action_136 (42) = happyShift action_144
action_136 (60) = happyShift action_145
action_136 (61) = happyShift action_146
action_136 (62) = happyShift action_147
action_136 (63) = happyShift action_148
action_136 (64) = happyShift action_149
action_136 (65) = happyShift action_150
action_136 (66) = happyShift action_151
action_136 (67) = happyShift action_152
action_136 (68) = happyShift action_153
action_136 (69) = happyShift action_154
action_136 (70) = happyShift action_155
action_136 (72) = happyShift action_156
action_136 (73) = happyShift action_157
action_136 (77) = happyShift action_174
action_136 _ = happyFail (happyExpListPerState 136)

action_137 (61) = happyShift action_20
action_137 (71) = happyShift action_22
action_137 (75) = happyShift action_23
action_137 (76) = happyShift action_24
action_137 (80) = happyShift action_25
action_137 (81) = happyShift action_26
action_137 (82) = happyShift action_27
action_137 (83) = happyShift action_28
action_137 (84) = happyShift action_29
action_137 (85) = happyShift action_30
action_137 (86) = happyShift action_31
action_137 (9) = happyGoto action_8
action_137 (10) = happyGoto action_9
action_137 (11) = happyGoto action_10
action_137 (12) = happyGoto action_11
action_137 (13) = happyGoto action_12
action_137 (14) = happyGoto action_13
action_137 (15) = happyGoto action_89
action_137 (16) = happyGoto action_173
action_137 (17) = happyGoto action_91
action_137 (18) = happyGoto action_15
action_137 _ = happyFail (happyExpListPerState 137)

action_138 (41) = happyShift action_143
action_138 (42) = happyShift action_144
action_138 (60) = happyShift action_145
action_138 (61) = happyShift action_146
action_138 (62) = happyShift action_147
action_138 (63) = happyShift action_148
action_138 (64) = happyShift action_149
action_138 (65) = happyShift action_150
action_138 (66) = happyShift action_151
action_138 (67) = happyShift action_152
action_138 (68) = happyShift action_153
action_138 (69) = happyShift action_154
action_138 (70) = happyShift action_155
action_138 _ = happyReduce_101

action_139 (41) = happyShift action_143
action_139 (42) = happyShift action_144
action_139 _ = happyReduce_102

action_140 _ = happyReduce_80

action_141 _ = happyReduce_82

action_142 _ = happyReduce_81

action_143 (76) = happyShift action_172
action_143 _ = happyFail (happyExpListPerState 143)

action_144 (76) = happyShift action_171
action_144 _ = happyFail (happyExpListPerState 144)

action_145 (50) = happyShift action_111
action_145 (51) = happyShift action_112
action_145 (52) = happyShift action_113
action_145 (61) = happyShift action_114
action_145 (71) = happyShift action_115
action_145 (75) = happyShift action_116
action_145 (76) = happyShift action_117
action_145 (80) = happyShift action_118
action_145 (81) = happyShift action_26
action_145 (82) = happyShift action_27
action_145 (83) = happyShift action_28
action_145 (84) = happyShift action_29
action_145 (85) = happyShift action_30
action_145 (86) = happyShift action_31
action_145 (9) = happyGoto action_8
action_145 (10) = happyGoto action_9
action_145 (11) = happyGoto action_10
action_145 (12) = happyGoto action_11
action_145 (13) = happyGoto action_12
action_145 (14) = happyGoto action_108
action_145 (29) = happyGoto action_170
action_145 (30) = happyGoto action_110
action_145 _ = happyFail (happyExpListPerState 145)

action_146 (50) = happyShift action_111
action_146 (51) = happyShift action_112
action_146 (52) = happyShift action_113
action_146 (61) = happyShift action_114
action_146 (71) = happyShift action_115
action_146 (75) = happyShift action_116
action_146 (76) = happyShift action_117
action_146 (80) = happyShift action_118
action_146 (81) = happyShift action_26
action_146 (82) = happyShift action_27
action_146 (83) = happyShift action_28
action_146 (84) = happyShift action_29
action_146 (85) = happyShift action_30
action_146 (86) = happyShift action_31
action_146 (9) = happyGoto action_8
action_146 (10) = happyGoto action_9
action_146 (11) = happyGoto action_10
action_146 (12) = happyGoto action_11
action_146 (13) = happyGoto action_12
action_146 (14) = happyGoto action_108
action_146 (29) = happyGoto action_169
action_146 (30) = happyGoto action_110
action_146 _ = happyFail (happyExpListPerState 146)

action_147 (50) = happyShift action_111
action_147 (51) = happyShift action_112
action_147 (52) = happyShift action_113
action_147 (61) = happyShift action_114
action_147 (71) = happyShift action_115
action_147 (75) = happyShift action_116
action_147 (76) = happyShift action_117
action_147 (80) = happyShift action_118
action_147 (81) = happyShift action_26
action_147 (82) = happyShift action_27
action_147 (83) = happyShift action_28
action_147 (84) = happyShift action_29
action_147 (85) = happyShift action_30
action_147 (86) = happyShift action_31
action_147 (9) = happyGoto action_8
action_147 (10) = happyGoto action_9
action_147 (11) = happyGoto action_10
action_147 (12) = happyGoto action_11
action_147 (13) = happyGoto action_12
action_147 (14) = happyGoto action_108
action_147 (29) = happyGoto action_168
action_147 (30) = happyGoto action_110
action_147 _ = happyFail (happyExpListPerState 147)

action_148 (50) = happyShift action_111
action_148 (51) = happyShift action_112
action_148 (52) = happyShift action_113
action_148 (61) = happyShift action_114
action_148 (71) = happyShift action_115
action_148 (75) = happyShift action_116
action_148 (76) = happyShift action_117
action_148 (80) = happyShift action_118
action_148 (81) = happyShift action_26
action_148 (82) = happyShift action_27
action_148 (83) = happyShift action_28
action_148 (84) = happyShift action_29
action_148 (85) = happyShift action_30
action_148 (86) = happyShift action_31
action_148 (9) = happyGoto action_8
action_148 (10) = happyGoto action_9
action_148 (11) = happyGoto action_10
action_148 (12) = happyGoto action_11
action_148 (13) = happyGoto action_12
action_148 (14) = happyGoto action_108
action_148 (29) = happyGoto action_167
action_148 (30) = happyGoto action_110
action_148 _ = happyFail (happyExpListPerState 148)

action_149 (50) = happyShift action_111
action_149 (51) = happyShift action_112
action_149 (52) = happyShift action_113
action_149 (61) = happyShift action_114
action_149 (71) = happyShift action_115
action_149 (75) = happyShift action_116
action_149 (76) = happyShift action_117
action_149 (80) = happyShift action_118
action_149 (81) = happyShift action_26
action_149 (82) = happyShift action_27
action_149 (83) = happyShift action_28
action_149 (84) = happyShift action_29
action_149 (85) = happyShift action_30
action_149 (86) = happyShift action_31
action_149 (9) = happyGoto action_8
action_149 (10) = happyGoto action_9
action_149 (11) = happyGoto action_10
action_149 (12) = happyGoto action_11
action_149 (13) = happyGoto action_12
action_149 (14) = happyGoto action_108
action_149 (29) = happyGoto action_166
action_149 (30) = happyGoto action_110
action_149 _ = happyFail (happyExpListPerState 149)

action_150 (50) = happyShift action_111
action_150 (51) = happyShift action_112
action_150 (52) = happyShift action_113
action_150 (61) = happyShift action_114
action_150 (71) = happyShift action_115
action_150 (75) = happyShift action_116
action_150 (76) = happyShift action_117
action_150 (80) = happyShift action_118
action_150 (81) = happyShift action_26
action_150 (82) = happyShift action_27
action_150 (83) = happyShift action_28
action_150 (84) = happyShift action_29
action_150 (85) = happyShift action_30
action_150 (86) = happyShift action_31
action_150 (9) = happyGoto action_8
action_150 (10) = happyGoto action_9
action_150 (11) = happyGoto action_10
action_150 (12) = happyGoto action_11
action_150 (13) = happyGoto action_12
action_150 (14) = happyGoto action_108
action_150 (29) = happyGoto action_165
action_150 (30) = happyGoto action_110
action_150 _ = happyFail (happyExpListPerState 150)

action_151 (50) = happyShift action_111
action_151 (51) = happyShift action_112
action_151 (52) = happyShift action_113
action_151 (61) = happyShift action_114
action_151 (71) = happyShift action_115
action_151 (75) = happyShift action_116
action_151 (76) = happyShift action_117
action_151 (80) = happyShift action_118
action_151 (81) = happyShift action_26
action_151 (82) = happyShift action_27
action_151 (83) = happyShift action_28
action_151 (84) = happyShift action_29
action_151 (85) = happyShift action_30
action_151 (86) = happyShift action_31
action_151 (9) = happyGoto action_8
action_151 (10) = happyGoto action_9
action_151 (11) = happyGoto action_10
action_151 (12) = happyGoto action_11
action_151 (13) = happyGoto action_12
action_151 (14) = happyGoto action_108
action_151 (29) = happyGoto action_164
action_151 (30) = happyGoto action_110
action_151 _ = happyFail (happyExpListPerState 151)

action_152 (50) = happyShift action_111
action_152 (51) = happyShift action_112
action_152 (52) = happyShift action_113
action_152 (61) = happyShift action_114
action_152 (71) = happyShift action_115
action_152 (75) = happyShift action_116
action_152 (76) = happyShift action_117
action_152 (80) = happyShift action_118
action_152 (81) = happyShift action_26
action_152 (82) = happyShift action_27
action_152 (83) = happyShift action_28
action_152 (84) = happyShift action_29
action_152 (85) = happyShift action_30
action_152 (86) = happyShift action_31
action_152 (9) = happyGoto action_8
action_152 (10) = happyGoto action_9
action_152 (11) = happyGoto action_10
action_152 (12) = happyGoto action_11
action_152 (13) = happyGoto action_12
action_152 (14) = happyGoto action_108
action_152 (29) = happyGoto action_163
action_152 (30) = happyGoto action_110
action_152 _ = happyFail (happyExpListPerState 152)

action_153 (50) = happyShift action_111
action_153 (51) = happyShift action_112
action_153 (52) = happyShift action_113
action_153 (61) = happyShift action_114
action_153 (71) = happyShift action_115
action_153 (75) = happyShift action_116
action_153 (76) = happyShift action_117
action_153 (80) = happyShift action_118
action_153 (81) = happyShift action_26
action_153 (82) = happyShift action_27
action_153 (83) = happyShift action_28
action_153 (84) = happyShift action_29
action_153 (85) = happyShift action_30
action_153 (86) = happyShift action_31
action_153 (9) = happyGoto action_8
action_153 (10) = happyGoto action_9
action_153 (11) = happyGoto action_10
action_153 (12) = happyGoto action_11
action_153 (13) = happyGoto action_12
action_153 (14) = happyGoto action_108
action_153 (29) = happyGoto action_162
action_153 (30) = happyGoto action_110
action_153 _ = happyFail (happyExpListPerState 153)

action_154 (50) = happyShift action_111
action_154 (51) = happyShift action_112
action_154 (52) = happyShift action_113
action_154 (61) = happyShift action_114
action_154 (71) = happyShift action_115
action_154 (75) = happyShift action_116
action_154 (76) = happyShift action_117
action_154 (80) = happyShift action_118
action_154 (81) = happyShift action_26
action_154 (82) = happyShift action_27
action_154 (83) = happyShift action_28
action_154 (84) = happyShift action_29
action_154 (85) = happyShift action_30
action_154 (86) = happyShift action_31
action_154 (9) = happyGoto action_8
action_154 (10) = happyGoto action_9
action_154 (11) = happyGoto action_10
action_154 (12) = happyGoto action_11
action_154 (13) = happyGoto action_12
action_154 (14) = happyGoto action_108
action_154 (29) = happyGoto action_161
action_154 (30) = happyGoto action_110
action_154 _ = happyFail (happyExpListPerState 154)

action_155 (50) = happyShift action_111
action_155 (51) = happyShift action_112
action_155 (52) = happyShift action_113
action_155 (61) = happyShift action_114
action_155 (71) = happyShift action_115
action_155 (75) = happyShift action_116
action_155 (76) = happyShift action_117
action_155 (80) = happyShift action_118
action_155 (81) = happyShift action_26
action_155 (82) = happyShift action_27
action_155 (83) = happyShift action_28
action_155 (84) = happyShift action_29
action_155 (85) = happyShift action_30
action_155 (86) = happyShift action_31
action_155 (9) = happyGoto action_8
action_155 (10) = happyGoto action_9
action_155 (11) = happyGoto action_10
action_155 (12) = happyGoto action_11
action_155 (13) = happyGoto action_12
action_155 (14) = happyGoto action_108
action_155 (29) = happyGoto action_160
action_155 (30) = happyGoto action_110
action_155 _ = happyFail (happyExpListPerState 155)

action_156 (50) = happyShift action_111
action_156 (51) = happyShift action_112
action_156 (52) = happyShift action_113
action_156 (61) = happyShift action_114
action_156 (71) = happyShift action_115
action_156 (75) = happyShift action_116
action_156 (76) = happyShift action_117
action_156 (80) = happyShift action_118
action_156 (81) = happyShift action_26
action_156 (82) = happyShift action_27
action_156 (83) = happyShift action_28
action_156 (84) = happyShift action_29
action_156 (85) = happyShift action_30
action_156 (86) = happyShift action_31
action_156 (9) = happyGoto action_8
action_156 (10) = happyGoto action_9
action_156 (11) = happyGoto action_10
action_156 (12) = happyGoto action_11
action_156 (13) = happyGoto action_12
action_156 (14) = happyGoto action_108
action_156 (29) = happyGoto action_159
action_156 (30) = happyGoto action_110
action_156 _ = happyFail (happyExpListPerState 156)

action_157 (50) = happyShift action_111
action_157 (51) = happyShift action_112
action_157 (52) = happyShift action_113
action_157 (61) = happyShift action_114
action_157 (71) = happyShift action_115
action_157 (75) = happyShift action_116
action_157 (76) = happyShift action_117
action_157 (80) = happyShift action_118
action_157 (81) = happyShift action_26
action_157 (82) = happyShift action_27
action_157 (83) = happyShift action_28
action_157 (84) = happyShift action_29
action_157 (85) = happyShift action_30
action_157 (86) = happyShift action_31
action_157 (9) = happyGoto action_8
action_157 (10) = happyGoto action_9
action_157 (11) = happyGoto action_10
action_157 (12) = happyGoto action_11
action_157 (13) = happyGoto action_12
action_157 (14) = happyGoto action_108
action_157 (29) = happyGoto action_158
action_157 (30) = happyGoto action_110
action_157 _ = happyFail (happyExpListPerState 157)

action_158 (41) = happyShift action_143
action_158 (42) = happyShift action_144
action_158 (60) = happyShift action_145
action_158 (61) = happyShift action_146
action_158 (62) = happyShift action_147
action_158 (63) = happyShift action_148
action_158 (64) = happyShift action_149
action_158 (65) = happyShift action_150
action_158 (66) = happyShift action_151
action_158 (67) = happyShift action_152
action_158 (68) = happyShift action_153
action_158 (69) = happyShift action_154
action_158 (70) = happyShift action_155
action_158 (72) = happyShift action_156
action_158 _ = happyReduce_100

action_159 (41) = happyShift action_143
action_159 (42) = happyShift action_144
action_159 (60) = happyShift action_145
action_159 (61) = happyShift action_146
action_159 (62) = happyShift action_147
action_159 (63) = happyShift action_148
action_159 (64) = happyShift action_149
action_159 (65) = happyShift action_150
action_159 (66) = happyShift action_151
action_159 (67) = happyShift action_152
action_159 (68) = happyShift action_153
action_159 (69) = happyShift action_154
action_159 (70) = happyShift action_155
action_159 _ = happyReduce_99

action_160 (41) = happyShift action_143
action_160 (42) = happyShift action_144
action_160 (60) = happyShift action_145
action_160 (61) = happyShift action_146
action_160 (62) = happyShift action_147
action_160 (63) = happyShift action_148
action_160 (64) = happyShift action_149
action_160 (65) = happyFail []
action_160 (66) = happyFail []
action_160 (67) = happyFail []
action_160 (68) = happyFail []
action_160 (69) = happyFail []
action_160 (70) = happyFail []
action_160 _ = happyReduce_98

action_161 (41) = happyShift action_143
action_161 (42) = happyShift action_144
action_161 (60) = happyShift action_145
action_161 (61) = happyShift action_146
action_161 (62) = happyShift action_147
action_161 (63) = happyShift action_148
action_161 (64) = happyShift action_149
action_161 (65) = happyFail []
action_161 (66) = happyFail []
action_161 (67) = happyFail []
action_161 (68) = happyFail []
action_161 (69) = happyFail []
action_161 (70) = happyFail []
action_161 _ = happyReduce_97

action_162 (41) = happyShift action_143
action_162 (42) = happyShift action_144
action_162 (60) = happyShift action_145
action_162 (61) = happyShift action_146
action_162 (62) = happyShift action_147
action_162 (63) = happyShift action_148
action_162 (64) = happyShift action_149
action_162 (65) = happyFail []
action_162 (66) = happyFail []
action_162 (67) = happyFail []
action_162 (68) = happyFail []
action_162 (69) = happyFail []
action_162 (70) = happyFail []
action_162 _ = happyReduce_96

action_163 (41) = happyShift action_143
action_163 (42) = happyShift action_144
action_163 (60) = happyShift action_145
action_163 (61) = happyShift action_146
action_163 (62) = happyShift action_147
action_163 (63) = happyShift action_148
action_163 (64) = happyShift action_149
action_163 (65) = happyFail []
action_163 (66) = happyFail []
action_163 (67) = happyFail []
action_163 (68) = happyFail []
action_163 (69) = happyFail []
action_163 (70) = happyFail []
action_163 _ = happyReduce_95

action_164 (41) = happyShift action_143
action_164 (42) = happyShift action_144
action_164 (60) = happyShift action_145
action_164 (61) = happyShift action_146
action_164 (62) = happyShift action_147
action_164 (63) = happyShift action_148
action_164 (64) = happyShift action_149
action_164 (65) = happyFail []
action_164 (66) = happyFail []
action_164 (67) = happyFail []
action_164 (68) = happyFail []
action_164 (69) = happyFail []
action_164 (70) = happyFail []
action_164 _ = happyReduce_94

action_165 (41) = happyShift action_143
action_165 (42) = happyShift action_144
action_165 (60) = happyShift action_145
action_165 (61) = happyShift action_146
action_165 (62) = happyShift action_147
action_165 (63) = happyShift action_148
action_165 (64) = happyShift action_149
action_165 (65) = happyFail []
action_165 (66) = happyFail []
action_165 (67) = happyFail []
action_165 (68) = happyFail []
action_165 (69) = happyFail []
action_165 (70) = happyFail []
action_165 _ = happyReduce_93

action_166 (41) = happyShift action_143
action_166 (42) = happyShift action_144
action_166 _ = happyReduce_92

action_167 (41) = happyShift action_143
action_167 (42) = happyShift action_144
action_167 _ = happyReduce_91

action_168 (41) = happyShift action_143
action_168 (42) = happyShift action_144
action_168 _ = happyReduce_90

action_169 (41) = happyShift action_143
action_169 (42) = happyShift action_144
action_169 (62) = happyShift action_147
action_169 (63) = happyShift action_148
action_169 (64) = happyShift action_149
action_169 _ = happyReduce_89

action_170 (41) = happyShift action_143
action_170 (42) = happyShift action_144
action_170 (62) = happyShift action_147
action_170 (63) = happyShift action_148
action_170 (64) = happyShift action_149
action_170 _ = happyReduce_88

action_171 (36) = happyShift action_5
action_171 (61) = happyShift action_20
action_171 (71) = happyShift action_22
action_171 (75) = happyShift action_23
action_171 (76) = happyShift action_195
action_171 (80) = happyShift action_25
action_171 (81) = happyShift action_26
action_171 (82) = happyShift action_27
action_171 (83) = happyShift action_28
action_171 (84) = happyShift action_29
action_171 (85) = happyShift action_30
action_171 (86) = happyShift action_31
action_171 (4) = happyGoto action_196
action_171 (5) = happyGoto action_4
action_171 (9) = happyGoto action_8
action_171 (10) = happyGoto action_9
action_171 (11) = happyGoto action_10
action_171 (12) = happyGoto action_11
action_171 (13) = happyGoto action_12
action_171 (14) = happyGoto action_13
action_171 (15) = happyGoto action_89
action_171 (16) = happyGoto action_197
action_171 (17) = happyGoto action_91
action_171 (18) = happyGoto action_15
action_171 _ = happyFail (happyExpListPerState 171)

action_172 (36) = happyShift action_5
action_172 (61) = happyShift action_20
action_172 (71) = happyShift action_22
action_172 (75) = happyShift action_23
action_172 (76) = happyShift action_195
action_172 (80) = happyShift action_25
action_172 (81) = happyShift action_26
action_172 (82) = happyShift action_27
action_172 (83) = happyShift action_28
action_172 (84) = happyShift action_29
action_172 (85) = happyShift action_30
action_172 (86) = happyShift action_31
action_172 (4) = happyGoto action_193
action_172 (5) = happyGoto action_4
action_172 (9) = happyGoto action_8
action_172 (10) = happyGoto action_9
action_172 (11) = happyGoto action_10
action_172 (12) = happyGoto action_11
action_172 (13) = happyGoto action_12
action_172 (14) = happyGoto action_13
action_172 (15) = happyGoto action_89
action_172 (16) = happyGoto action_194
action_172 (17) = happyGoto action_91
action_172 (18) = happyGoto action_15
action_172 _ = happyFail (happyExpListPerState 172)

action_173 (77) = happyShift action_192
action_173 (78) = happyShift action_96
action_173 _ = happyFail (happyExpListPerState 173)

action_174 _ = happyReduce_83

action_175 (46) = happyShift action_190
action_175 (47) = happyShift action_191
action_175 (78) = happyShift action_180
action_175 (35) = happyGoto action_189
action_175 _ = happyReduce_112

action_176 _ = happyReduce_58

action_177 (81) = happyShift action_188
action_177 _ = happyFail (happyExpListPerState 177)

action_178 _ = happyReduce_105

action_179 (61) = happyShift action_20
action_179 (71) = happyShift action_22
action_179 (75) = happyShift action_23
action_179 (76) = happyShift action_24
action_179 (80) = happyShift action_25
action_179 (81) = happyShift action_26
action_179 (82) = happyShift action_27
action_179 (83) = happyShift action_28
action_179 (84) = happyShift action_29
action_179 (85) = happyShift action_30
action_179 (86) = happyShift action_31
action_179 (9) = happyGoto action_8
action_179 (10) = happyGoto action_9
action_179 (11) = happyGoto action_10
action_179 (12) = happyGoto action_11
action_179 (13) = happyGoto action_12
action_179 (14) = happyGoto action_13
action_179 (15) = happyGoto action_187
action_179 (18) = happyGoto action_15
action_179 _ = happyFail (happyExpListPerState 179)

action_180 (75) = happyShift action_185
action_180 (80) = happyShift action_186
action_180 _ = happyFail (happyExpListPerState 180)

action_181 (65) = happyShift action_184
action_181 _ = happyFail (happyExpListPerState 181)

action_182 (65) = happyShift action_183
action_182 _ = happyFail (happyExpListPerState 182)

action_183 (80) = happyShift action_203
action_183 _ = happyFail (happyExpListPerState 183)

action_184 (75) = happyShift action_202
action_184 _ = happyFail (happyExpListPerState 184)

action_185 _ = happyReduce_108

action_186 _ = happyReduce_109

action_187 (60) = happyShift action_54
action_187 (61) = happyShift action_55
action_187 (62) = happyShift action_56
action_187 (63) = happyShift action_57
action_187 (64) = happyShift action_58
action_187 (65) = happyShift action_59
action_187 (66) = happyShift action_60
action_187 (67) = happyShift action_61
action_187 (68) = happyShift action_62
action_187 (69) = happyShift action_63
action_187 (70) = happyShift action_64
action_187 (72) = happyShift action_65
action_187 (73) = happyShift action_66
action_187 _ = happyReduce_110

action_188 _ = happyReduce_72

action_189 _ = happyReduce_113

action_190 _ = happyReduce_114

action_191 _ = happyReduce_115

action_192 _ = happyReduce_78

action_193 (77) = happyShift action_201
action_193 _ = happyFail (happyExpListPerState 193)

action_194 (77) = happyShift action_200
action_194 (78) = happyShift action_96
action_194 _ = happyFail (happyExpListPerState 194)

action_195 (36) = happyShift action_5
action_195 (61) = happyShift action_20
action_195 (71) = happyShift action_22
action_195 (75) = happyShift action_23
action_195 (76) = happyShift action_195
action_195 (80) = happyShift action_25
action_195 (81) = happyShift action_26
action_195 (82) = happyShift action_27
action_195 (83) = happyShift action_28
action_195 (84) = happyShift action_29
action_195 (85) = happyShift action_30
action_195 (86) = happyShift action_31
action_195 (4) = happyGoto action_7
action_195 (5) = happyGoto action_4
action_195 (9) = happyGoto action_8
action_195 (10) = happyGoto action_9
action_195 (11) = happyGoto action_10
action_195 (12) = happyGoto action_11
action_195 (13) = happyGoto action_12
action_195 (14) = happyGoto action_13
action_195 (15) = happyGoto action_45
action_195 (18) = happyGoto action_15
action_195 _ = happyFail (happyExpListPerState 195)

action_196 (77) = happyShift action_199
action_196 _ = happyFail (happyExpListPerState 196)

action_197 (77) = happyShift action_198
action_197 (78) = happyShift action_96
action_197 _ = happyFail (happyExpListPerState 197)

action_198 _ = happyReduce_87

action_199 _ = happyReduce_86

action_200 _ = happyReduce_85

action_201 _ = happyReduce_84

action_202 _ = happyReduce_69

action_203 _ = happyReduce_70

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_2 Nothing S.All
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  4 happyReduction_3
happyReduction_3 (HappyAbsSyn22  happy_var_3)
	(HappyAbsSyn19  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_2 (Just happy_var_3) S.All
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 (HappyAbsSyn19  happy_var_3)
	_
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_3 Nothing S.Distinct
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 4 happyReduction_5
happyReduction_5 ((HappyAbsSyn22  happy_var_4) `HappyStk`
	(HappyAbsSyn19  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (S.Select happy_var_3 (Just happy_var_4) S.Distinct
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_3  4 happyReduction_6
happyReduction_6 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_2 happy_var_1 happy_var_3
	)
happyReduction_6 _ _ _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_3  4 happyReduction_7
happyReduction_7 (HappyAbsSyn4  happy_var_3)
	(HappyAbsSyn6  happy_var_2)
	(HappyAbsSyn4  happy_var_1)
	 =  HappyAbsSyn4
		 (happy_var_2 happy_var_1 happy_var_3
	)
happyReduction_7 _ _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_3  5 happyReduction_8
happyReduction_8 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_8 _ _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  6 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Union S.Distinct q1 q2
	)

happyReduce_10 = happySpecReduce_2  6 happyReduction_10
happyReduction_10 _
	_
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Union S.All q1 q2
	)

happyReduce_11 = happySpecReduce_2  6 happyReduction_11
happyReduction_11 _
	_
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Union S.Distinct q1 q2
	)

happyReduce_12 = happySpecReduce_1  7 happyReduction_12
happyReduction_12 _
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Intersect S.Distinct q1 q2
	)

happyReduce_13 = happySpecReduce_2  7 happyReduction_13
happyReduction_13 _
	_
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Intersect S.All q1 q2
	)

happyReduce_14 = happySpecReduce_2  7 happyReduction_14
happyReduction_14 _
	_
	 =  HappyAbsSyn6
		 (\q1 q2 -> S.Intersect S.All q1 q2
	)

happyReduce_15 = happySpecReduce_1  8 happyReduction_15
happyReduction_15 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn8
		 (Just happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_2  8 happyReduction_16
happyReduction_16 (HappyTerminal (T.Identifier happy_var_2))
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_16 _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  9 happyReduction_17
happyReduction_17 _
	 =  HappyAbsSyn9
		 ((S.Boolean S.Null)
	)

happyReduce_18 = happySpecReduce_1  10 happyReduction_18
happyReduction_18 _
	 =  HappyAbsSyn9
		 ((S.Boolean S.TrueVal)
	)

happyReduce_19 = happySpecReduce_1  11 happyReduction_19
happyReduction_19 _
	 =  HappyAbsSyn9
		 ((S.Boolean S.FalseVal)
	)

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyTerminal ((T.String happy_var_1)))
	 =  HappyAbsSyn9
		 ((S.String happy_var_1)
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyTerminal ((T.Integer happy_var_1)))
	 =  HappyAbsSyn9
		 ((S.Number happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  13 happyReduction_22
happyReduction_22 (HappyTerminal ((T.Float happy_var_1)))
	 =  HappyAbsSyn9
		 ((S.Number happy_var_1)
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  14 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  14 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_1  14 happyReduction_26
happyReduction_26 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_26 _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  14 happyReduction_27
happyReduction_27 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn9
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_1  15 happyReduction_28
happyReduction_28 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Constant happy_var_1
	)
happyReduction_28 _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_1  15 happyReduction_29
happyReduction_29 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn15
		 (S.Identifier happy_var_1
	)
happyReduction_29 _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_1  15 happyReduction_30
happyReduction_30 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn15
		 (S.Identifier happy_var_1
	)
happyReduction_30 _  = notHappyAtAll 

happyReduce_31 = happyReduce 4 15 happyReduction_31
happyReduction_31 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (S.Function happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_32 = happySpecReduce_1  15 happyReduction_32
happyReduction_32 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Operator happy_var_1
	)
happyReduction_32 _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  15 happyReduction_33
happyReduction_33 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  16 happyReduction_34
happyReduction_34 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([ happy_var_1 ]
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  16 happyReduction_35
happyReduction_35 (HappyAbsSyn17  happy_var_3)
	_
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 ((happy_var_3 : happy_var_1)
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  17 happyReduction_36
happyReduction_36 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_1
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  18 happyReduction_37
happyReduction_37 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  18 happyReduction_38
happyReduction_38 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  18 happyReduction_39
happyReduction_39 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  18 happyReduction_40
happyReduction_40 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  18 happyReduction_41
happyReduction_41 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_3  18 happyReduction_42
happyReduction_42 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_42 _ _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  18 happyReduction_43
happyReduction_43 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  18 happyReduction_44
happyReduction_44 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_3  18 happyReduction_45
happyReduction_45 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_45 _ _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  18 happyReduction_46
happyReduction_46 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_3  18 happyReduction_47
happyReduction_47 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_47 _ _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  18 happyReduction_48
happyReduction_48 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  18 happyReduction_49
happyReduction_49 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  18 happyReduction_50
happyReduction_50 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (S.Not happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  18 happyReduction_51
happyReduction_51 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (S.Neg happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  19 happyReduction_52
happyReduction_52 _
	 =  HappyAbsSyn19
		 (S.Wildcard
	)

happyReduce_53 = happySpecReduce_1  19 happyReduction_53
happyReduction_53 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn19
		 (S.Columns happy_var_1
	)
happyReduction_53 _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_1  20 happyReduction_54
happyReduction_54 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 ([happy_var_1]
	)
happyReduction_54 _  = notHappyAtAll 

happyReduce_55 = happySpecReduce_3  20 happyReduction_55
happyReduction_55 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_3 : happy_var_1
	)
happyReduction_55 _ _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_1  21 happyReduction_56
happyReduction_56 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn21
		 (S.Column happy_var_1 Nothing
	)
happyReduction_56 _  = notHappyAtAll 

happyReduce_57 = happySpecReduce_2  21 happyReduction_57
happyReduction_57 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn21
		 (S.Column happy_var_1 happy_var_2
	)
happyReduction_57 _ _  = notHappyAtAll 

happyReduce_58 = happyReduce 6 22 happyReduction_58
happyReduction_58 ((HappyAbsSyn27  happy_var_6) `HappyStk`
	(HappyAbsSyn34  happy_var_5) `HappyStk`
	(HappyAbsSyn31  happy_var_4) `HappyStk`
	(HappyAbsSyn28  happy_var_3) `HappyStk`
	(HappyAbsSyn23  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn22
		 (S.mkFromClause happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6
	) `HappyStk` happyRest

happyReduce_59 = happySpecReduce_1  23 happyReduction_59
happyReduction_59 (HappyAbsSyn24  happy_var_1)
	 =  HappyAbsSyn23
		 ([ happy_var_1 ]
	)
happyReduction_59 _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  23 happyReduction_60
happyReduction_60 (HappyAbsSyn24  happy_var_3)
	_
	(HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn23
		 (happy_var_3 : happy_var_1
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  24 happyReduction_61
happyReduction_61 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn24
		 (S.Table happy_var_1 Nothing
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_2  24 happyReduction_62
happyReduction_62 (HappyAbsSyn8  happy_var_2)
	(HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn24
		 (S.Table happy_var_1 happy_var_2
	)
happyReduction_62 _ _  = notHappyAtAll 

happyReduce_63 = happyReduce 4 24 happyReduction_63
happyReduction_63 ((HappyAbsSyn24  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn24  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (S.Join S.Natural happy_var_1 happy_var_4 Nothing
	) `HappyStk` happyRest

happyReduce_64 = happyReduce 4 24 happyReduction_64
happyReduction_64 ((HappyAbsSyn26  happy_var_4) `HappyStk`
	(HappyAbsSyn24  happy_var_3) `HappyStk`
	(HappyAbsSyn25  happy_var_2) `HappyStk`
	(HappyAbsSyn24  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn24
		 (S.Join happy_var_2 happy_var_1 happy_var_3 happy_var_4
	) `HappyStk` happyRest

happyReduce_65 = happySpecReduce_2  25 happyReduction_65
happyReduction_65 _
	_
	 =  HappyAbsSyn25
		 (S.Inner
	)

happyReduce_66 = happySpecReduce_2  25 happyReduction_66
happyReduction_66 _
	_
	 =  HappyAbsSyn25
		 (S.LeftOuter
	)

happyReduce_67 = happySpecReduce_2  25 happyReduction_67
happyReduction_67 _
	_
	 =  HappyAbsSyn25
		 (S.RightOuter
	)

happyReduce_68 = happySpecReduce_2  25 happyReduction_68
happyReduction_68 _
	_
	 =  HappyAbsSyn25
		 (S.FullOuter
	)

happyReduce_69 = happyReduce 4 26 happyReduction_69
happyReduction_69 ((HappyTerminal (T.Identifier happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Just (happy_var_2, happy_var_4)
	) `HappyStk` happyRest

happyReduce_70 = happyReduce 4 26 happyReduction_70
happyReduction_70 ((HappyTerminal (T.Dotwalk happy_var_4)) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Dotwalk happy_var_2)) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn26
		 (Just (happy_var_2, happy_var_4)
	) `HappyStk` happyRest

happyReduce_71 = happySpecReduce_0  27 happyReduction_71
happyReduction_71  =  HappyAbsSyn27
		 (Nothing
	)

happyReduce_72 = happySpecReduce_2  27 happyReduction_72
happyReduction_72 (HappyTerminal ((T.Integer happy_var_2)))
	_
	 =  HappyAbsSyn27
		 (Just happy_var_2
	)
happyReduction_72 _ _  = notHappyAtAll 

happyReduce_73 = happySpecReduce_0  28 happyReduction_73
happyReduction_73  =  HappyAbsSyn28
		 (Nothing
	)

happyReduce_74 = happySpecReduce_2  28 happyReduction_74
happyReduction_74 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn28
		 (Just happy_var_2
	)
happyReduction_74 _ _  = notHappyAtAll 

happyReduce_75 = happySpecReduce_1  29 happyReduction_75
happyReduction_75 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Constant happy_var_1
	)
happyReduction_75 _  = notHappyAtAll 

happyReduce_76 = happySpecReduce_1  29 happyReduction_76
happyReduction_76 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn15
		 (S.Identifier happy_var_1
	)
happyReduction_76 _  = notHappyAtAll 

happyReduce_77 = happySpecReduce_1  29 happyReduction_77
happyReduction_77 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn15
		 (S.Identifier happy_var_1
	)
happyReduction_77 _  = notHappyAtAll 

happyReduce_78 = happyReduce 4 29 happyReduction_78
happyReduction_78 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn15
		 (S.Function happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_79 = happySpecReduce_1  29 happyReduction_79
happyReduction_79 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Operator happy_var_1
	)
happyReduction_79 _  = notHappyAtAll 

happyReduce_80 = happySpecReduce_2  29 happyReduction_80
happyReduction_80 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.SubQuery S.QAny happy_var_2
	)
happyReduction_80 _ _  = notHappyAtAll 

happyReduce_81 = happySpecReduce_2  29 happyReduction_81
happyReduction_81 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.SubQuery S.QAll happy_var_2
	)
happyReduction_81 _ _  = notHappyAtAll 

happyReduce_82 = happySpecReduce_2  29 happyReduction_82
happyReduction_82 (HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.SubQuery S.Exists happy_var_2
	)
happyReduction_82 _ _  = notHappyAtAll 

happyReduce_83 = happySpecReduce_3  29 happyReduction_83
happyReduction_83 _
	(HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (happy_var_2
	)
happyReduction_83 _ _ _  = notHappyAtAll 

happyReduce_84 = happyReduce 5 30 happyReduction_84
happyReduction_84 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (S.In happy_var_1 ( S.Rows happy_var_4)
	) `HappyStk` happyRest

happyReduce_85 = happyReduce 5 30 happyReduction_85
happyReduction_85 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (S.In happy_var_1 (S.Row happy_var_4)
	) `HappyStk` happyRest

happyReduce_86 = happyReduce 5 30 happyReduction_86
happyReduction_86 (_ `HappyStk`
	(HappyAbsSyn4  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (S.NotIn happy_var_1 (S.Rows happy_var_4)
	) `HappyStk` happyRest

happyReduce_87 = happyReduce 5 30 happyReduction_87
happyReduction_87 (_ `HappyStk`
	(HappyAbsSyn16  happy_var_4) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	(HappyAbsSyn15  happy_var_1) `HappyStk`
	happyRest)
	 = HappyAbsSyn18
		 (S.NotIn happy_var_1 (S.Row happy_var_4)
	) `HappyStk` happyRest

happyReduce_88 = happySpecReduce_3  30 happyReduction_88
happyReduction_88 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_88 _ _ _  = notHappyAtAll 

happyReduce_89 = happySpecReduce_3  30 happyReduction_89
happyReduction_89 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_89 _ _ _  = notHappyAtAll 

happyReduce_90 = happySpecReduce_3  30 happyReduction_90
happyReduction_90 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_90 _ _ _  = notHappyAtAll 

happyReduce_91 = happySpecReduce_3  30 happyReduction_91
happyReduction_91 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_91 _ _ _  = notHappyAtAll 

happyReduce_92 = happySpecReduce_3  30 happyReduction_92
happyReduction_92 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_92 _ _ _  = notHappyAtAll 

happyReduce_93 = happySpecReduce_3  30 happyReduction_93
happyReduction_93 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_93 _ _ _  = notHappyAtAll 

happyReduce_94 = happySpecReduce_3  30 happyReduction_94
happyReduction_94 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_94 _ _ _  = notHappyAtAll 

happyReduce_95 = happySpecReduce_3  30 happyReduction_95
happyReduction_95 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_95 _ _ _  = notHappyAtAll 

happyReduce_96 = happySpecReduce_3  30 happyReduction_96
happyReduction_96 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_96 _ _ _  = notHappyAtAll 

happyReduce_97 = happySpecReduce_3  30 happyReduction_97
happyReduction_97 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_97 _ _ _  = notHappyAtAll 

happyReduce_98 = happySpecReduce_3  30 happyReduction_98
happyReduction_98 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_98 _ _ _  = notHappyAtAll 

happyReduce_99 = happySpecReduce_3  30 happyReduction_99
happyReduction_99 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_99 _ _ _  = notHappyAtAll 

happyReduce_100 = happySpecReduce_3  30 happyReduction_100
happyReduction_100 (HappyAbsSyn15  happy_var_3)
	_
	(HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_100 _ _ _  = notHappyAtAll 

happyReduce_101 = happySpecReduce_2  30 happyReduction_101
happyReduction_101 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (S.Not happy_var_2
	)
happyReduction_101 _ _  = notHappyAtAll 

happyReduce_102 = happySpecReduce_2  30 happyReduction_102
happyReduction_102 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn18
		 (S.Neg happy_var_2
	)
happyReduction_102 _ _  = notHappyAtAll 

happyReduce_103 = happySpecReduce_0  31 happyReduction_103
happyReduction_103  =  HappyAbsSyn31
		 (Nothing
	)

happyReduce_104 = happySpecReduce_2  31 happyReduction_104
happyReduction_104 (HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (Just $ S.GroupBy happy_var_2 Nothing
	)
happyReduction_104 _ _  = notHappyAtAll 

happyReduce_105 = happySpecReduce_3  31 happyReduction_105
happyReduction_105 (HappyAbsSyn33  happy_var_3)
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn31
		 (Just $ S.GroupBy happy_var_2 (Just happy_var_3)
	)
happyReduction_105 _ _ _  = notHappyAtAll 

happyReduce_106 = happySpecReduce_1  32 happyReduction_106
happyReduction_106 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn32
		 ([ happy_var_1 ]
	)
happyReduction_106 _  = notHappyAtAll 

happyReduce_107 = happySpecReduce_1  32 happyReduction_107
happyReduction_107 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn32
		 ([ happy_var_1 ]
	)
happyReduction_107 _  = notHappyAtAll 

happyReduce_108 = happySpecReduce_3  32 happyReduction_108
happyReduction_108 (HappyTerminal (T.Identifier happy_var_3))
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_3 : happy_var_1
	)
happyReduction_108 _ _ _  = notHappyAtAll 

happyReduce_109 = happySpecReduce_3  32 happyReduction_109
happyReduction_109 (HappyTerminal (T.Dotwalk happy_var_3))
	_
	(HappyAbsSyn32  happy_var_1)
	 =  HappyAbsSyn32
		 (happy_var_3 : happy_var_1
	)
happyReduction_109 _ _ _  = notHappyAtAll 

happyReduce_110 = happySpecReduce_2  33 happyReduction_110
happyReduction_110 (HappyAbsSyn15  happy_var_2)
	_
	 =  HappyAbsSyn33
		 (S.Having happy_var_2
	)
happyReduction_110 _ _  = notHappyAtAll 

happyReduce_111 = happySpecReduce_0  34 happyReduction_111
happyReduction_111  =  HappyAbsSyn34
		 (Nothing
	)

happyReduce_112 = happySpecReduce_2  34 happyReduction_112
happyReduction_112 (HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn34
		 (Just $ S.OrderBy happy_var_2 Nothing
	)
happyReduction_112 _ _  = notHappyAtAll 

happyReduce_113 = happySpecReduce_3  34 happyReduction_113
happyReduction_113 (HappyAbsSyn35  happy_var_3)
	(HappyAbsSyn32  happy_var_2)
	_
	 =  HappyAbsSyn34
		 (Just $ S.OrderBy happy_var_2 (Just happy_var_3)
	)
happyReduction_113 _ _ _  = notHappyAtAll 

happyReduce_114 = happySpecReduce_1  35 happyReduction_114
happyReduction_114 _
	 =  HappyAbsSyn35
		 (S.Ascending
	)

happyReduce_115 = happySpecReduce_1  35 happyReduction_115
happyReduction_115 _
	 =  HappyAbsSyn35
		 (S.Descending
	)

happyNewToken action sts stk [] =
	action 87 87 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.Select -> cont 36;
	T.From -> cont 37;
	T.Where -> cont 38;
	T.GroupBy -> cont 39;
	T.Having -> cont 40;
	T.In -> cont 41;
	T.NotIn -> cont 42;
	T.Distinct -> cont 43;
	T.Limit -> cont 44;
	T.OrderBy -> cont 45;
	T.Ascending -> cont 46;
	T.Descending -> cont 47;
	T.Union -> cont 48;
	T.Intersect -> cont 49;
	T.All -> cont 50;
	T.Exists -> cont 51;
	T.Any -> cont 52;
	T.Left -> cont 53;
	T.Right -> cont 54;
	T.Inner -> cont 55;
	T.Outer -> cont 56;
	T.Natural -> cont 57;
	T.Join -> cont 58;
	T.On -> cont 59;
	T.Plus -> cont 60;
	T.Minus -> cont 61;
	T.Asterisk -> cont 62;
	T.FloatDivide -> cont 63;
	T.Modulo -> cont 64;
	T.Equals -> cont 65;
	T.NotEquals -> cont 66;
	T.LT -> cont 67;
	T.LTE -> cont 68;
	T.GT -> cont 69;
	T.GTE -> cont 70;
	T.Not -> cont 71;
	T.And -> cont 72;
	T.Or -> cont 73;
	T.As -> cont 74;
	T.Identifier happy_dollar_dollar -> cont 75;
	T.LeftParen -> cont 76;
	T.RightParen -> cont 77;
	T.Comma -> cont 78;
	T.BlockComment happy_dollar_dollar -> cont 79;
	T.Dotwalk happy_dollar_dollar -> cont 80;
	(T.Integer happy_dollar_dollar) -> cont 81;
	(T.Float happy_dollar_dollar) -> cont 82;
	(T.String happy_dollar_dollar) -> cont 83;
	(T.TrueVal) -> cont 84;
	(T.FalseVal) -> cont 85;
	(T.Null ) -> cont 86;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 87 tk tks = happyError' (tks, explist)
happyError_ explist _ tk tks = happyError' ((tk:tks), explist)

newtype HappyIdentity a = HappyIdentity a
happyIdentity = HappyIdentity
happyRunIdentity (HappyIdentity a) = a

instance Functor HappyIdentity where
    fmap f (HappyIdentity a) = HappyIdentity (f a)

instance Applicative HappyIdentity where
    pure  = HappyIdentity
    (<*>) = ap
instance Monad HappyIdentity where
    return = pure
    (HappyIdentity p) >>= q = q p

happyThen :: () => HappyIdentity a -> (a -> HappyIdentity b) -> HappyIdentity b
happyThen = (>>=)
happyReturn :: () => a -> HappyIdentity a
happyReturn = (return)
happyThen1 m k tks = (>>=) m (\a -> k a tks)
happyReturn1 :: () => a -> b -> HappyIdentity a
happyReturn1 = \a tks -> (return) a
happyError' :: () => ([(Tok)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq


type Tok = T.Token

parseError :: [Tok] -> a
parseError tok = error $ "Parse error around " ++ (show tok)
{-# LINE 1 "templates\GenericTemplate.hs" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
{-# LINE 1 "<built-in>" #-}
{-# LINE 1 "<command-line>" #-}
{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "D:/GitHub/haskell-platform/build/ghc-bindist/local/lib/include/ghcversion.h" #-}















{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "F:/Users/randy/AppData/Local/Temp/ghc1900_0/ghc_2.h" #-}


























































































































































































{-# LINE 8 "<command-line>" #-}
{-# LINE 1 "templates\\\\GenericTemplate.hs" #-}
-- Id: GenericTemplate.hs,v 1.26 2005/01/14 14:47:22 simonmar Exp 









{-# LINE 43 "templates\\\\GenericTemplate.hs" #-}

data Happy_IntList = HappyCons Int Happy_IntList







{-# LINE 65 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 75 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 84 "templates\\\\GenericTemplate.hs" #-}

infixr 9 `HappyStk`
data HappyStk a = HappyStk a (HappyStk a)

-----------------------------------------------------------------------------
-- starting the parse

happyParse start_state = happyNewToken start_state notHappyAtAll notHappyAtAll

-----------------------------------------------------------------------------
-- Accepting the parse

-- If the current token is (1), it means we've just accepted a partial
-- parse (a %partial parser).  We must ignore the saved token on the top of
-- the stack in this case.
happyAccept (1) tk st sts (_ `HappyStk` ans `HappyStk` _) =
        happyReturn1 ans
happyAccept j tk st sts (HappyStk ans _) = 
         (happyReturn1 ans)

-----------------------------------------------------------------------------
-- Arrays only: do the next action

{-# LINE 137 "templates\\\\GenericTemplate.hs" #-}

{-# LINE 147 "templates\\\\GenericTemplate.hs" #-}
indexShortOffAddr arr off = arr Happy_Data_Array.! off


{-# INLINE happyLt #-}
happyLt x y = (x < y)






readArrayBit arr bit =
    Bits.testBit (indexShortOffAddr arr (bit `div` 16)) (bit `mod` 16)






-----------------------------------------------------------------------------
-- HappyState data type (not arrays)



newtype HappyState b c = HappyState
        (Int ->                    -- token number
         Int ->                    -- token number (yes, again)
         b ->                           -- token semantic value
         HappyState b c ->              -- current state
         [HappyState b c] ->            -- state stack
         c)



-----------------------------------------------------------------------------
-- Shifting a token

happyShift new_state (1) tk st sts stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--     trace "shifting the error token" $
     new_state i i tk (HappyState (new_state)) ((st):(sts)) (stk)

happyShift new_state i tk st sts stk =
     happyNewToken new_state ((st):(sts)) ((HappyTerminal (tk))`HappyStk`stk)

-- happyReduce is specialised for the common cases.

happySpecReduce_0 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_0 nt fn j tk st@((HappyState (action))) sts stk
     = action nt j tk st ((st):(sts)) (fn `HappyStk` stk)

happySpecReduce_1 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_1 nt fn j tk _ sts@(((st@(HappyState (action))):(_))) (v1`HappyStk`stk')
     = let r = fn v1 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_2 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_2 nt fn j tk _ ((_):(sts@(((st@(HappyState (action))):(_))))) (v1`HappyStk`v2`HappyStk`stk')
     = let r = fn v1 v2 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happySpecReduce_3 i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happySpecReduce_3 nt fn j tk _ ((_):(((_):(sts@(((st@(HappyState (action))):(_))))))) (v1`HappyStk`v2`HappyStk`v3`HappyStk`stk')
     = let r = fn v1 v2 v3 in
       happySeq r (action nt j tk st sts (r `HappyStk` stk'))

happyReduce k i fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyReduce k nt fn j tk st sts stk
     = case happyDrop (k - ((1) :: Int)) sts of
         sts1@(((st1@(HappyState (action))):(_))) ->
                let r = fn stk in  -- it doesn't hurt to always seq here...
                happyDoSeq r (action nt j tk st1 sts1 r)

happyMonadReduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonadReduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
          let drop_stk = happyDropStk k stk in
          happyThen1 (fn stk tk) (\r -> action nt j tk st1 sts1 (r `HappyStk` drop_stk))

happyMonad2Reduce k nt fn (1) tk st sts stk
     = happyFail [] (1) tk st sts stk
happyMonad2Reduce k nt fn j tk st sts stk =
      case happyDrop k ((st):(sts)) of
        sts1@(((st1@(HappyState (action))):(_))) ->
         let drop_stk = happyDropStk k stk





             _ = nt :: Int
             new_state = action

          in
          happyThen1 (fn stk tk) (\r -> happyNewToken new_state sts1 (r `HappyStk` drop_stk))

happyDrop (0) l = l
happyDrop n ((_):(t)) = happyDrop (n - ((1) :: Int)) t

happyDropStk (0) l = l
happyDropStk n (x `HappyStk` xs) = happyDropStk (n - ((1)::Int)) xs

-----------------------------------------------------------------------------
-- Moving to a new state after a reduction

{-# LINE 267 "templates\\\\GenericTemplate.hs" #-}
happyGoto action j tk st = action j j tk (HappyState action)


-----------------------------------------------------------------------------
-- Error recovery ((1) is the error token)

-- parse error if we are in recovery and we fail again
happyFail explist (1) tk old_st _ stk@(x `HappyStk` _) =
     let i = (case x of { HappyErrorToken (i) -> i }) in
--      trace "failing" $ 
        happyError_ explist i tk

{-  We don't need state discarding for our restricted implementation of
    "error".  In fact, it can cause some bogus parses, so I've disabled it
    for now --SDM

-- discard a state
happyFail  (1) tk old_st (((HappyState (action))):(sts)) 
                                                (saved_tok `HappyStk` _ `HappyStk` stk) =
--      trace ("discarding state, depth " ++ show (length stk))  $
        action (1) (1) tk (HappyState (action)) sts ((saved_tok`HappyStk`stk))
-}

-- Enter error recovery: generate an error token,
--                       save the old token and carry on.
happyFail explist i tk (HappyState (action)) sts stk =
--      trace "entering error recovery" $
        action (1) (1) tk (HappyState (action)) sts ( (HappyErrorToken (i)) `HappyStk` stk)

-- Internal happy errors:

notHappyAtAll :: a
notHappyAtAll = error "Internal Happy error\n"

-----------------------------------------------------------------------------
-- Hack to get the typechecker to accept our action functions







-----------------------------------------------------------------------------
-- Seq-ing.  If the --strict flag is given, then Happy emits 
--      happySeq = happyDoSeq
-- otherwise it emits
--      happySeq = happyDontSeq

happyDoSeq, happyDontSeq :: a -> b -> b
happyDoSeq   a b = a `seq` b
happyDontSeq a b = b

-----------------------------------------------------------------------------
-- Don't inline any functions from the template.  GHC has a nasty habit
-- of deciding to inline happyGoto everywhere, which increases the size of
-- the generated parser quite a bit.

{-# LINE 333 "templates\\\\GenericTemplate.hs" #-}
{-# NOINLINE happyShift #-}
{-# NOINLINE happySpecReduce_0 #-}
{-# NOINLINE happySpecReduce_1 #-}
{-# NOINLINE happySpecReduce_2 #-}
{-# NOINLINE happySpecReduce_3 #-}
{-# NOINLINE happyReduce #-}
{-# NOINLINE happyMonadReduce #-}
{-# NOINLINE happyGoto #-}
{-# NOINLINE happyFail #-}

-- end of Happy Template.
