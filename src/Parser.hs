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
	| HappyAbsSyn5 (S.Alias)
	| HappyAbsSyn6 (S.PrimitiveType)
	| HappyAbsSyn12 (S.Expr)
	| HappyAbsSyn13 (S.Args)
	| HappyAbsSyn14 (S.Arg)
	| HappyAbsSyn15 (S.OperatorType)
	| HappyAbsSyn16 (S.SelectType)
	| HappyAbsSyn17 ([ S.Column ])
	| HappyAbsSyn18 (S.Column)
	| HappyAbsSyn19 (S.FromClause)
	| HappyAbsSyn20 ([ S.Table ])
	| HappyAbsSyn21 (S.Table)
	| HappyAbsSyn22 (Maybe S.Limit)
	| HappyAbsSyn23 (Maybe S.Where)
	| HappyAbsSyn24 (Maybe S.GroupBy)
	| HappyAbsSyn25 ([ String ])
	| HappyAbsSyn26 (S.Having)
	| HappyAbsSyn27 (Maybe S.OrderBy)
	| HappyAbsSyn28 (S.Direction)

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
 action_106 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
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
 happyReduce_70 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,428) ([0,4096,0,0,2,0,0,0,16384,0,0,64,0,2048,0,0,0,0,0,0,0,64,192,65073,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63487,0,0,0,0,0,0,0,64,0,0,0,0,0,0,512,0,0,0,0,0,0,0,0,4108,4067,0,0,32768,25088,508,0,0,0,0,0,0,0,512,61832,7,0,0,0,32,0,0,0,8200,8134,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,0,32752,35,0,0,0,4100,4067,0,0,49152,511,0,0,0,0,0,0,0,16,0,0,0,0,0,64,65073,0,0,0,0,0,0,0,0,16384,0,0,0,0,0,0,0,0,1024,58128,15,0,0,128,64610,1,0,0,16400,16268,0,0,0,34818,2033,0,0,16384,12544,254,0,0,2048,50720,31,0,0,256,63684,3,0,0,32800,32536,0,0,0,4100,4067,0,0,32768,25088,508,0,0,4096,35904,63,0,0,512,61832,7,0,0,64,65073,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,65024,47,0,0,0,65472,1,0,0,0,248,0,0,0,0,31,0,0,0,57344,3,0,0,0,31744,0,0,0,0,3968,0,0,0,0,496,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,7168,0,0,0,0,896,0,0,32768,0,0,16,0,0,0,0,0,0,0,0,3072,0,0,0,0,0,0,0,0,0,0,0,0,0,49144,1,0,0,0,0,6,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32800,32536,0,0,0,0,0,0,4096,0,0,0,0,0,4096,35904,63,0,0,0,128,0,0,0,0,0,0,0,0,57340,0,0,0,4,0,0,0,0,0,2048,1,0,0,0,0,0,0,32,0,256,0,0,0,0,0,0,0,0,0,0,0,32768,0,0,0,0,0,0,16896,0,0,6144,0,512,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,4096,35904,63,0,0,0,4224,0,0,0,0,0,0,0,0,0,0,0,0,32768,7167,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","Alias","Null","True","False","String","Number","Primitive","Expr","Args","Arg","Operator","SType","Columns","Column","From","Tables","Table","Limit","Where","GroupBy","ColNames","Having","OrderBy","Direction","select","from","where","groupBy","having","in","distinct","limit","orderBy","ascending","descending","union","intersect","all","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","'('","')'","','","bc","dotwalk","integer","float","string","true","false","null","%eof"]
        bit_start = st * 77
        bit_end = (st + 1) * 77
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..76]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (29) = happyShift action_4
action_0 (66) = happyShift action_2
action_0 (4) = happyGoto action_3
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (66) = happyShift action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 (29) = happyShift action_4
action_2 (66) = happyShift action_2
action_2 (4) = happyGoto action_29
action_2 _ = happyFail (happyExpListPerState 2)

action_3 (77) = happyAccept
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (35) = happyShift action_16
action_4 (51) = happyShift action_17
action_4 (52) = happyShift action_18
action_4 (61) = happyShift action_19
action_4 (65) = happyShift action_20
action_4 (66) = happyShift action_21
action_4 (70) = happyShift action_22
action_4 (71) = happyShift action_23
action_4 (72) = happyShift action_24
action_4 (73) = happyShift action_25
action_4 (74) = happyShift action_26
action_4 (75) = happyShift action_27
action_4 (76) = happyShift action_28
action_4 (6) = happyGoto action_5
action_4 (7) = happyGoto action_6
action_4 (8) = happyGoto action_7
action_4 (9) = happyGoto action_8
action_4 (10) = happyGoto action_9
action_4 (11) = happyGoto action_10
action_4 (12) = happyGoto action_11
action_4 (15) = happyGoto action_12
action_4 (16) = happyGoto action_13
action_4 (17) = happyGoto action_14
action_4 (18) = happyGoto action_15
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_14

action_6 _ = happyReduce_15

action_7 _ = happyReduce_16

action_8 _ = happyReduce_17

action_9 _ = happyReduce_18

action_10 _ = happyReduce_19

action_11 (50) = happyShift action_40
action_11 (51) = happyShift action_41
action_11 (52) = happyShift action_42
action_11 (53) = happyShift action_43
action_11 (54) = happyShift action_44
action_11 (55) = happyShift action_45
action_11 (56) = happyShift action_46
action_11 (57) = happyShift action_47
action_11 (58) = happyShift action_48
action_11 (59) = happyShift action_49
action_11 (60) = happyShift action_50
action_11 (62) = happyShift action_51
action_11 (63) = happyShift action_52
action_11 (64) = happyShift action_53
action_11 (65) = happyShift action_54
action_11 (5) = happyGoto action_39
action_11 _ = happyReduce_47

action_12 _ = happyReduce_23

action_13 (30) = happyShift action_38
action_13 (19) = happyGoto action_37
action_13 _ = happyReduce_2

action_14 (68) = happyShift action_36
action_14 _ = happyReduce_44

action_15 _ = happyReduce_45

action_16 (51) = happyShift action_17
action_16 (52) = happyShift action_18
action_16 (61) = happyShift action_19
action_16 (65) = happyShift action_20
action_16 (66) = happyShift action_21
action_16 (70) = happyShift action_22
action_16 (71) = happyShift action_23
action_16 (72) = happyShift action_24
action_16 (73) = happyShift action_25
action_16 (74) = happyShift action_26
action_16 (75) = happyShift action_27
action_16 (76) = happyShift action_28
action_16 (6) = happyGoto action_5
action_16 (7) = happyGoto action_6
action_16 (8) = happyGoto action_7
action_16 (9) = happyGoto action_8
action_16 (10) = happyGoto action_9
action_16 (11) = happyGoto action_10
action_16 (12) = happyGoto action_11
action_16 (15) = happyGoto action_12
action_16 (16) = happyGoto action_35
action_16 (17) = happyGoto action_14
action_16 (18) = happyGoto action_15
action_16 _ = happyFail (happyExpListPerState 16)

action_17 (51) = happyShift action_17
action_17 (61) = happyShift action_19
action_17 (65) = happyShift action_20
action_17 (66) = happyShift action_21
action_17 (70) = happyShift action_22
action_17 (71) = happyShift action_23
action_17 (72) = happyShift action_24
action_17 (73) = happyShift action_25
action_17 (74) = happyShift action_26
action_17 (75) = happyShift action_27
action_17 (76) = happyShift action_28
action_17 (6) = happyGoto action_5
action_17 (7) = happyGoto action_6
action_17 (8) = happyGoto action_7
action_17 (9) = happyGoto action_8
action_17 (10) = happyGoto action_9
action_17 (11) = happyGoto action_10
action_17 (12) = happyGoto action_34
action_17 (15) = happyGoto action_12
action_17 _ = happyFail (happyExpListPerState 17)

action_18 _ = happyReduce_43

action_19 (51) = happyShift action_17
action_19 (61) = happyShift action_19
action_19 (65) = happyShift action_20
action_19 (66) = happyShift action_21
action_19 (70) = happyShift action_22
action_19 (71) = happyShift action_23
action_19 (72) = happyShift action_24
action_19 (73) = happyShift action_25
action_19 (74) = happyShift action_26
action_19 (75) = happyShift action_27
action_19 (76) = happyShift action_28
action_19 (6) = happyGoto action_5
action_19 (7) = happyGoto action_6
action_19 (8) = happyGoto action_7
action_19 (9) = happyGoto action_8
action_19 (10) = happyGoto action_9
action_19 (11) = happyGoto action_10
action_19 (12) = happyGoto action_33
action_19 (15) = happyGoto action_12
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (66) = happyShift action_32
action_20 _ = happyReduce_20

action_21 (51) = happyShift action_17
action_21 (61) = happyShift action_19
action_21 (65) = happyShift action_20
action_21 (66) = happyShift action_21
action_21 (70) = happyShift action_22
action_21 (71) = happyShift action_23
action_21 (72) = happyShift action_24
action_21 (73) = happyShift action_25
action_21 (74) = happyShift action_26
action_21 (75) = happyShift action_27
action_21 (76) = happyShift action_28
action_21 (6) = happyGoto action_5
action_21 (7) = happyGoto action_6
action_21 (8) = happyGoto action_7
action_21 (9) = happyGoto action_8
action_21 (10) = happyGoto action_9
action_21 (11) = happyGoto action_10
action_21 (12) = happyGoto action_31
action_21 (15) = happyGoto action_12
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_21

action_23 _ = happyReduce_12

action_24 _ = happyReduce_13

action_25 _ = happyReduce_11

action_26 _ = happyReduce_9

action_27 _ = happyReduce_10

action_28 _ = happyReduce_8

action_29 (67) = happyShift action_30
action_29 _ = happyFail (happyExpListPerState 29)

action_30 _ = happyReduce_1

action_31 (50) = happyShift action_40
action_31 (51) = happyShift action_41
action_31 (52) = happyShift action_42
action_31 (53) = happyShift action_43
action_31 (54) = happyShift action_44
action_31 (55) = happyShift action_45
action_31 (56) = happyShift action_46
action_31 (57) = happyShift action_47
action_31 (58) = happyShift action_48
action_31 (59) = happyShift action_49
action_31 (60) = happyShift action_50
action_31 (62) = happyShift action_51
action_31 (63) = happyShift action_52
action_31 (67) = happyShift action_77
action_31 _ = happyFail (happyExpListPerState 31)

action_32 (51) = happyShift action_17
action_32 (61) = happyShift action_19
action_32 (65) = happyShift action_20
action_32 (66) = happyShift action_21
action_32 (70) = happyShift action_22
action_32 (71) = happyShift action_23
action_32 (72) = happyShift action_24
action_32 (73) = happyShift action_25
action_32 (74) = happyShift action_26
action_32 (75) = happyShift action_27
action_32 (76) = happyShift action_28
action_32 (6) = happyGoto action_5
action_32 (7) = happyGoto action_6
action_32 (8) = happyGoto action_7
action_32 (9) = happyGoto action_8
action_32 (10) = happyGoto action_9
action_32 (11) = happyGoto action_10
action_32 (12) = happyGoto action_74
action_32 (13) = happyGoto action_75
action_32 (14) = happyGoto action_76
action_32 (15) = happyGoto action_12
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (50) = happyShift action_40
action_33 (51) = happyShift action_41
action_33 (52) = happyShift action_42
action_33 (53) = happyShift action_43
action_33 (54) = happyShift action_44
action_33 (55) = happyShift action_45
action_33 (56) = happyShift action_46
action_33 (57) = happyShift action_47
action_33 (58) = happyShift action_48
action_33 (59) = happyShift action_49
action_33 (60) = happyShift action_50
action_33 _ = happyReduce_41

action_34 _ = happyReduce_42

action_35 (30) = happyShift action_38
action_35 (19) = happyGoto action_73
action_35 _ = happyReduce_4

action_36 (51) = happyShift action_17
action_36 (61) = happyShift action_19
action_36 (65) = happyShift action_20
action_36 (66) = happyShift action_21
action_36 (70) = happyShift action_22
action_36 (71) = happyShift action_23
action_36 (72) = happyShift action_24
action_36 (73) = happyShift action_25
action_36 (74) = happyShift action_26
action_36 (75) = happyShift action_27
action_36 (76) = happyShift action_28
action_36 (6) = happyGoto action_5
action_36 (7) = happyGoto action_6
action_36 (8) = happyGoto action_7
action_36 (9) = happyGoto action_8
action_36 (10) = happyGoto action_9
action_36 (11) = happyGoto action_10
action_36 (12) = happyGoto action_11
action_36 (15) = happyGoto action_12
action_36 (18) = happyGoto action_72
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_3

action_38 (65) = happyShift action_71
action_38 (20) = happyGoto action_69
action_38 (21) = happyGoto action_70
action_38 _ = happyFail (happyExpListPerState 38)

action_39 _ = happyReduce_48

action_40 (51) = happyShift action_17
action_40 (61) = happyShift action_19
action_40 (65) = happyShift action_20
action_40 (66) = happyShift action_21
action_40 (70) = happyShift action_22
action_40 (71) = happyShift action_23
action_40 (72) = happyShift action_24
action_40 (73) = happyShift action_25
action_40 (74) = happyShift action_26
action_40 (75) = happyShift action_27
action_40 (76) = happyShift action_28
action_40 (6) = happyGoto action_5
action_40 (7) = happyGoto action_6
action_40 (8) = happyGoto action_7
action_40 (9) = happyGoto action_8
action_40 (10) = happyGoto action_9
action_40 (11) = happyGoto action_10
action_40 (12) = happyGoto action_68
action_40 (15) = happyGoto action_12
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (51) = happyShift action_17
action_41 (61) = happyShift action_19
action_41 (65) = happyShift action_20
action_41 (66) = happyShift action_21
action_41 (70) = happyShift action_22
action_41 (71) = happyShift action_23
action_41 (72) = happyShift action_24
action_41 (73) = happyShift action_25
action_41 (74) = happyShift action_26
action_41 (75) = happyShift action_27
action_41 (76) = happyShift action_28
action_41 (6) = happyGoto action_5
action_41 (7) = happyGoto action_6
action_41 (8) = happyGoto action_7
action_41 (9) = happyGoto action_8
action_41 (10) = happyGoto action_9
action_41 (11) = happyGoto action_10
action_41 (12) = happyGoto action_67
action_41 (15) = happyGoto action_12
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (51) = happyShift action_17
action_42 (61) = happyShift action_19
action_42 (65) = happyShift action_20
action_42 (66) = happyShift action_21
action_42 (70) = happyShift action_22
action_42 (71) = happyShift action_23
action_42 (72) = happyShift action_24
action_42 (73) = happyShift action_25
action_42 (74) = happyShift action_26
action_42 (75) = happyShift action_27
action_42 (76) = happyShift action_28
action_42 (6) = happyGoto action_5
action_42 (7) = happyGoto action_6
action_42 (8) = happyGoto action_7
action_42 (9) = happyGoto action_8
action_42 (10) = happyGoto action_9
action_42 (11) = happyGoto action_10
action_42 (12) = happyGoto action_66
action_42 (15) = happyGoto action_12
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (51) = happyShift action_17
action_43 (61) = happyShift action_19
action_43 (65) = happyShift action_20
action_43 (66) = happyShift action_21
action_43 (70) = happyShift action_22
action_43 (71) = happyShift action_23
action_43 (72) = happyShift action_24
action_43 (73) = happyShift action_25
action_43 (74) = happyShift action_26
action_43 (75) = happyShift action_27
action_43 (76) = happyShift action_28
action_43 (6) = happyGoto action_5
action_43 (7) = happyGoto action_6
action_43 (8) = happyGoto action_7
action_43 (9) = happyGoto action_8
action_43 (10) = happyGoto action_9
action_43 (11) = happyGoto action_10
action_43 (12) = happyGoto action_65
action_43 (15) = happyGoto action_12
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (51) = happyShift action_17
action_44 (61) = happyShift action_19
action_44 (65) = happyShift action_20
action_44 (66) = happyShift action_21
action_44 (70) = happyShift action_22
action_44 (71) = happyShift action_23
action_44 (72) = happyShift action_24
action_44 (73) = happyShift action_25
action_44 (74) = happyShift action_26
action_44 (75) = happyShift action_27
action_44 (76) = happyShift action_28
action_44 (6) = happyGoto action_5
action_44 (7) = happyGoto action_6
action_44 (8) = happyGoto action_7
action_44 (9) = happyGoto action_8
action_44 (10) = happyGoto action_9
action_44 (11) = happyGoto action_10
action_44 (12) = happyGoto action_64
action_44 (15) = happyGoto action_12
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (51) = happyShift action_17
action_45 (61) = happyShift action_19
action_45 (65) = happyShift action_20
action_45 (66) = happyShift action_21
action_45 (70) = happyShift action_22
action_45 (71) = happyShift action_23
action_45 (72) = happyShift action_24
action_45 (73) = happyShift action_25
action_45 (74) = happyShift action_26
action_45 (75) = happyShift action_27
action_45 (76) = happyShift action_28
action_45 (6) = happyGoto action_5
action_45 (7) = happyGoto action_6
action_45 (8) = happyGoto action_7
action_45 (9) = happyGoto action_8
action_45 (10) = happyGoto action_9
action_45 (11) = happyGoto action_10
action_45 (12) = happyGoto action_63
action_45 (15) = happyGoto action_12
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (51) = happyShift action_17
action_46 (61) = happyShift action_19
action_46 (65) = happyShift action_20
action_46 (66) = happyShift action_21
action_46 (70) = happyShift action_22
action_46 (71) = happyShift action_23
action_46 (72) = happyShift action_24
action_46 (73) = happyShift action_25
action_46 (74) = happyShift action_26
action_46 (75) = happyShift action_27
action_46 (76) = happyShift action_28
action_46 (6) = happyGoto action_5
action_46 (7) = happyGoto action_6
action_46 (8) = happyGoto action_7
action_46 (9) = happyGoto action_8
action_46 (10) = happyGoto action_9
action_46 (11) = happyGoto action_10
action_46 (12) = happyGoto action_62
action_46 (15) = happyGoto action_12
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (51) = happyShift action_17
action_47 (61) = happyShift action_19
action_47 (65) = happyShift action_20
action_47 (66) = happyShift action_21
action_47 (70) = happyShift action_22
action_47 (71) = happyShift action_23
action_47 (72) = happyShift action_24
action_47 (73) = happyShift action_25
action_47 (74) = happyShift action_26
action_47 (75) = happyShift action_27
action_47 (76) = happyShift action_28
action_47 (6) = happyGoto action_5
action_47 (7) = happyGoto action_6
action_47 (8) = happyGoto action_7
action_47 (9) = happyGoto action_8
action_47 (10) = happyGoto action_9
action_47 (11) = happyGoto action_10
action_47 (12) = happyGoto action_61
action_47 (15) = happyGoto action_12
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (51) = happyShift action_17
action_48 (61) = happyShift action_19
action_48 (65) = happyShift action_20
action_48 (66) = happyShift action_21
action_48 (70) = happyShift action_22
action_48 (71) = happyShift action_23
action_48 (72) = happyShift action_24
action_48 (73) = happyShift action_25
action_48 (74) = happyShift action_26
action_48 (75) = happyShift action_27
action_48 (76) = happyShift action_28
action_48 (6) = happyGoto action_5
action_48 (7) = happyGoto action_6
action_48 (8) = happyGoto action_7
action_48 (9) = happyGoto action_8
action_48 (10) = happyGoto action_9
action_48 (11) = happyGoto action_10
action_48 (12) = happyGoto action_60
action_48 (15) = happyGoto action_12
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (51) = happyShift action_17
action_49 (61) = happyShift action_19
action_49 (65) = happyShift action_20
action_49 (66) = happyShift action_21
action_49 (70) = happyShift action_22
action_49 (71) = happyShift action_23
action_49 (72) = happyShift action_24
action_49 (73) = happyShift action_25
action_49 (74) = happyShift action_26
action_49 (75) = happyShift action_27
action_49 (76) = happyShift action_28
action_49 (6) = happyGoto action_5
action_49 (7) = happyGoto action_6
action_49 (8) = happyGoto action_7
action_49 (9) = happyGoto action_8
action_49 (10) = happyGoto action_9
action_49 (11) = happyGoto action_10
action_49 (12) = happyGoto action_59
action_49 (15) = happyGoto action_12
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (51) = happyShift action_17
action_50 (61) = happyShift action_19
action_50 (65) = happyShift action_20
action_50 (66) = happyShift action_21
action_50 (70) = happyShift action_22
action_50 (71) = happyShift action_23
action_50 (72) = happyShift action_24
action_50 (73) = happyShift action_25
action_50 (74) = happyShift action_26
action_50 (75) = happyShift action_27
action_50 (76) = happyShift action_28
action_50 (6) = happyGoto action_5
action_50 (7) = happyGoto action_6
action_50 (8) = happyGoto action_7
action_50 (9) = happyGoto action_8
action_50 (10) = happyGoto action_9
action_50 (11) = happyGoto action_10
action_50 (12) = happyGoto action_58
action_50 (15) = happyGoto action_12
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (51) = happyShift action_17
action_51 (61) = happyShift action_19
action_51 (65) = happyShift action_20
action_51 (66) = happyShift action_21
action_51 (70) = happyShift action_22
action_51 (71) = happyShift action_23
action_51 (72) = happyShift action_24
action_51 (73) = happyShift action_25
action_51 (74) = happyShift action_26
action_51 (75) = happyShift action_27
action_51 (76) = happyShift action_28
action_51 (6) = happyGoto action_5
action_51 (7) = happyGoto action_6
action_51 (8) = happyGoto action_7
action_51 (9) = happyGoto action_8
action_51 (10) = happyGoto action_9
action_51 (11) = happyGoto action_10
action_51 (12) = happyGoto action_57
action_51 (15) = happyGoto action_12
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (51) = happyShift action_17
action_52 (61) = happyShift action_19
action_52 (65) = happyShift action_20
action_52 (66) = happyShift action_21
action_52 (70) = happyShift action_22
action_52 (71) = happyShift action_23
action_52 (72) = happyShift action_24
action_52 (73) = happyShift action_25
action_52 (74) = happyShift action_26
action_52 (75) = happyShift action_27
action_52 (76) = happyShift action_28
action_52 (6) = happyGoto action_5
action_52 (7) = happyGoto action_6
action_52 (8) = happyGoto action_7
action_52 (9) = happyGoto action_8
action_52 (10) = happyGoto action_9
action_52 (11) = happyGoto action_10
action_52 (12) = happyGoto action_56
action_52 (15) = happyGoto action_12
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (65) = happyShift action_55
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_6

action_55 _ = happyReduce_7

action_56 (50) = happyShift action_40
action_56 (51) = happyShift action_41
action_56 (52) = happyShift action_42
action_56 (53) = happyShift action_43
action_56 (54) = happyShift action_44
action_56 (55) = happyShift action_45
action_56 (56) = happyShift action_46
action_56 (57) = happyShift action_47
action_56 (58) = happyShift action_48
action_56 (59) = happyShift action_49
action_56 (60) = happyShift action_50
action_56 (62) = happyShift action_51
action_56 _ = happyReduce_40

action_57 (50) = happyShift action_40
action_57 (51) = happyShift action_41
action_57 (52) = happyShift action_42
action_57 (53) = happyShift action_43
action_57 (54) = happyShift action_44
action_57 (55) = happyShift action_45
action_57 (56) = happyShift action_46
action_57 (57) = happyShift action_47
action_57 (58) = happyShift action_48
action_57 (59) = happyShift action_49
action_57 (60) = happyShift action_50
action_57 _ = happyReduce_39

action_58 (50) = happyShift action_40
action_58 (51) = happyShift action_41
action_58 (52) = happyShift action_42
action_58 (53) = happyShift action_43
action_58 (54) = happyShift action_44
action_58 (55) = happyFail []
action_58 (56) = happyFail []
action_58 (57) = happyFail []
action_58 (58) = happyFail []
action_58 (59) = happyFail []
action_58 (60) = happyFail []
action_58 _ = happyReduce_38

action_59 (50) = happyShift action_40
action_59 (51) = happyShift action_41
action_59 (52) = happyShift action_42
action_59 (53) = happyShift action_43
action_59 (54) = happyShift action_44
action_59 (55) = happyFail []
action_59 (56) = happyFail []
action_59 (57) = happyFail []
action_59 (58) = happyFail []
action_59 (59) = happyFail []
action_59 (60) = happyFail []
action_59 _ = happyReduce_37

action_60 (50) = happyShift action_40
action_60 (51) = happyShift action_41
action_60 (52) = happyShift action_42
action_60 (53) = happyShift action_43
action_60 (54) = happyShift action_44
action_60 (55) = happyFail []
action_60 (56) = happyFail []
action_60 (57) = happyFail []
action_60 (58) = happyFail []
action_60 (59) = happyFail []
action_60 (60) = happyFail []
action_60 _ = happyReduce_36

action_61 (50) = happyShift action_40
action_61 (51) = happyShift action_41
action_61 (52) = happyShift action_42
action_61 (53) = happyShift action_43
action_61 (54) = happyShift action_44
action_61 (55) = happyFail []
action_61 (56) = happyFail []
action_61 (57) = happyFail []
action_61 (58) = happyFail []
action_61 (59) = happyFail []
action_61 (60) = happyFail []
action_61 _ = happyReduce_35

action_62 (50) = happyShift action_40
action_62 (51) = happyShift action_41
action_62 (52) = happyShift action_42
action_62 (53) = happyShift action_43
action_62 (54) = happyShift action_44
action_62 (55) = happyFail []
action_62 (56) = happyFail []
action_62 (57) = happyFail []
action_62 (58) = happyFail []
action_62 (59) = happyFail []
action_62 (60) = happyFail []
action_62 _ = happyReduce_34

action_63 (50) = happyShift action_40
action_63 (51) = happyShift action_41
action_63 (52) = happyShift action_42
action_63 (53) = happyShift action_43
action_63 (54) = happyShift action_44
action_63 (55) = happyFail []
action_63 (56) = happyFail []
action_63 (57) = happyFail []
action_63 (58) = happyFail []
action_63 (59) = happyFail []
action_63 (60) = happyFail []
action_63 _ = happyReduce_33

action_64 _ = happyReduce_32

action_65 _ = happyReduce_31

action_66 _ = happyReduce_30

action_67 (52) = happyShift action_42
action_67 (53) = happyShift action_43
action_67 (54) = happyShift action_44
action_67 _ = happyReduce_29

action_68 (52) = happyShift action_42
action_68 (53) = happyShift action_43
action_68 (54) = happyShift action_44
action_68 _ = happyReduce_28

action_69 (31) = happyShift action_82
action_69 (68) = happyShift action_83
action_69 (23) = happyGoto action_81
action_69 _ = happyReduce_56

action_70 _ = happyReduce_50

action_71 (64) = happyShift action_53
action_71 (65) = happyShift action_54
action_71 (5) = happyGoto action_80
action_71 _ = happyReduce_52

action_72 _ = happyReduce_46

action_73 _ = happyReduce_5

action_74 (50) = happyShift action_40
action_74 (51) = happyShift action_41
action_74 (52) = happyShift action_42
action_74 (53) = happyShift action_43
action_74 (54) = happyShift action_44
action_74 (55) = happyShift action_45
action_74 (56) = happyShift action_46
action_74 (57) = happyShift action_47
action_74 (58) = happyShift action_48
action_74 (59) = happyShift action_49
action_74 (60) = happyShift action_50
action_74 (62) = happyShift action_51
action_74 (63) = happyShift action_52
action_74 _ = happyReduce_27

action_75 (67) = happyShift action_78
action_75 (68) = happyShift action_79
action_75 _ = happyFail (happyExpListPerState 75)

action_76 _ = happyReduce_25

action_77 _ = happyReduce_24

action_78 _ = happyReduce_22

action_79 (51) = happyShift action_17
action_79 (61) = happyShift action_19
action_79 (65) = happyShift action_20
action_79 (66) = happyShift action_21
action_79 (70) = happyShift action_22
action_79 (71) = happyShift action_23
action_79 (72) = happyShift action_24
action_79 (73) = happyShift action_25
action_79 (74) = happyShift action_26
action_79 (75) = happyShift action_27
action_79 (76) = happyShift action_28
action_79 (6) = happyGoto action_5
action_79 (7) = happyGoto action_6
action_79 (8) = happyGoto action_7
action_79 (9) = happyGoto action_8
action_79 (10) = happyGoto action_9
action_79 (11) = happyGoto action_10
action_79 (12) = happyGoto action_74
action_79 (14) = happyGoto action_88
action_79 (15) = happyGoto action_12
action_79 _ = happyFail (happyExpListPerState 79)

action_80 _ = happyReduce_53

action_81 (32) = happyShift action_87
action_81 (24) = happyGoto action_86
action_81 _ = happyReduce_58

action_82 (51) = happyShift action_17
action_82 (61) = happyShift action_19
action_82 (65) = happyShift action_20
action_82 (66) = happyShift action_21
action_82 (70) = happyShift action_22
action_82 (71) = happyShift action_23
action_82 (72) = happyShift action_24
action_82 (73) = happyShift action_25
action_82 (74) = happyShift action_26
action_82 (75) = happyShift action_27
action_82 (76) = happyShift action_28
action_82 (6) = happyGoto action_5
action_82 (7) = happyGoto action_6
action_82 (8) = happyGoto action_7
action_82 (9) = happyGoto action_8
action_82 (10) = happyGoto action_9
action_82 (11) = happyGoto action_10
action_82 (12) = happyGoto action_85
action_82 (15) = happyGoto action_12
action_82 _ = happyFail (happyExpListPerState 82)

action_83 (65) = happyShift action_71
action_83 (21) = happyGoto action_84
action_83 _ = happyFail (happyExpListPerState 83)

action_84 _ = happyReduce_51

action_85 (50) = happyShift action_40
action_85 (51) = happyShift action_41
action_85 (52) = happyShift action_42
action_85 (53) = happyShift action_43
action_85 (54) = happyShift action_44
action_85 (55) = happyShift action_45
action_85 (56) = happyShift action_46
action_85 (57) = happyShift action_47
action_85 (58) = happyShift action_48
action_85 (59) = happyShift action_49
action_85 (60) = happyShift action_50
action_85 (62) = happyShift action_51
action_85 (63) = happyShift action_52
action_85 _ = happyReduce_57

action_86 (37) = happyShift action_93
action_86 (27) = happyGoto action_92
action_86 _ = happyReduce_66

action_87 (65) = happyShift action_90
action_87 (70) = happyShift action_91
action_87 (25) = happyGoto action_89
action_87 _ = happyFail (happyExpListPerState 87)

action_88 _ = happyReduce_26

action_89 (33) = happyShift action_98
action_89 (68) = happyShift action_99
action_89 (26) = happyGoto action_97
action_89 _ = happyReduce_59

action_90 _ = happyReduce_61

action_91 _ = happyReduce_62

action_92 (36) = happyShift action_96
action_92 (22) = happyGoto action_95
action_92 _ = happyReduce_54

action_93 (65) = happyShift action_90
action_93 (70) = happyShift action_91
action_93 (25) = happyGoto action_94
action_93 _ = happyFail (happyExpListPerState 93)

action_94 (38) = happyShift action_105
action_94 (39) = happyShift action_106
action_94 (68) = happyShift action_99
action_94 (28) = happyGoto action_104
action_94 _ = happyReduce_67

action_95 _ = happyReduce_49

action_96 (71) = happyShift action_103
action_96 _ = happyFail (happyExpListPerState 96)

action_97 _ = happyReduce_60

action_98 (51) = happyShift action_17
action_98 (61) = happyShift action_19
action_98 (65) = happyShift action_20
action_98 (66) = happyShift action_21
action_98 (70) = happyShift action_22
action_98 (71) = happyShift action_23
action_98 (72) = happyShift action_24
action_98 (73) = happyShift action_25
action_98 (74) = happyShift action_26
action_98 (75) = happyShift action_27
action_98 (76) = happyShift action_28
action_98 (6) = happyGoto action_5
action_98 (7) = happyGoto action_6
action_98 (8) = happyGoto action_7
action_98 (9) = happyGoto action_8
action_98 (10) = happyGoto action_9
action_98 (11) = happyGoto action_10
action_98 (12) = happyGoto action_102
action_98 (15) = happyGoto action_12
action_98 _ = happyFail (happyExpListPerState 98)

action_99 (65) = happyShift action_100
action_99 (70) = happyShift action_101
action_99 _ = happyFail (happyExpListPerState 99)

action_100 _ = happyReduce_63

action_101 _ = happyReduce_64

action_102 (50) = happyShift action_40
action_102 (51) = happyShift action_41
action_102 (52) = happyShift action_42
action_102 (53) = happyShift action_43
action_102 (54) = happyShift action_44
action_102 (55) = happyShift action_45
action_102 (56) = happyShift action_46
action_102 (57) = happyShift action_47
action_102 (58) = happyShift action_48
action_102 (59) = happyShift action_49
action_102 (60) = happyShift action_50
action_102 (62) = happyShift action_51
action_102 (63) = happyShift action_52
action_102 _ = happyReduce_65

action_103 _ = happyReduce_55

action_104 _ = happyReduce_68

action_105 _ = happyReduce_69

action_106 _ = happyReduce_70

happyReduce_1 = happySpecReduce_3  4 happyReduction_1
happyReduction_1 _
	(HappyAbsSyn4  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (happy_var_2
	)
happyReduction_1 _ _ _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  4 happyReduction_2
happyReduction_2 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_2 Nothing S.All
	)
happyReduction_2 _ _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_3  4 happyReduction_3
happyReduction_3 (HappyAbsSyn19  happy_var_3)
	(HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_2 (Just happy_var_3) S.All
	)
happyReduction_3 _ _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_3  4 happyReduction_4
happyReduction_4 (HappyAbsSyn16  happy_var_3)
	_
	_
	 =  HappyAbsSyn4
		 (S.Select happy_var_3 Nothing S.Distinct
	)
happyReduction_4 _ _ _  = notHappyAtAll 

happyReduce_5 = happyReduce 4 4 happyReduction_5
happyReduction_5 ((HappyAbsSyn19  happy_var_4) `HappyStk`
	(HappyAbsSyn16  happy_var_3) `HappyStk`
	_ `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn4
		 (S.Select happy_var_3 (Just happy_var_4) S.Distinct
	) `HappyStk` happyRest

happyReduce_6 = happySpecReduce_1  5 happyReduction_6
happyReduction_6 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn5
		 (Just happy_var_1
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  5 happyReduction_7
happyReduction_7 (HappyTerminal (T.Identifier happy_var_2))
	_
	 =  HappyAbsSyn5
		 (Just happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_1  6 happyReduction_8
happyReduction_8 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.Null)
	)

happyReduce_9 = happySpecReduce_1  7 happyReduction_9
happyReduction_9 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.TrueVal)
	)

happyReduce_10 = happySpecReduce_1  8 happyReduction_10
happyReduction_10 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.FalseVal)
	)

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 (HappyTerminal ((T.String happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.String happy_var_1)
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  10 happyReduction_12
happyReduction_12 (HappyTerminal ((T.Integer happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.Number happy_var_1)
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  10 happyReduction_13
happyReduction_13 (HappyTerminal ((T.Float happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.Number happy_var_1)
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happySpecReduce_1  11 happyReduction_14
happyReduction_14 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_14 _  = notHappyAtAll 

happyReduce_15 = happySpecReduce_1  11 happyReduction_15
happyReduction_15 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_1  11 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  11 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  11 happyReduction_18
happyReduction_18 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Constant happy_var_1
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn12
		 (S.Identifier happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn12
		 (S.Identifier happy_var_1
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happyReduce 4 12 happyReduction_22
happyReduction_22 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (S.Function happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_23 = happySpecReduce_1  12 happyReduction_23
happyReduction_23 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Operator happy_var_1
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  12 happyReduction_24
happyReduction_24 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  13 happyReduction_25
happyReduction_25 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([ happy_var_1 ]
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  13 happyReduction_26
happyReduction_26 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 ((happy_var_3 : happy_var_1)
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_1  14 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_27 _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  15 happyReduction_28
happyReduction_28 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  15 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  15 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  15 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  15 happyReduction_33
happyReduction_33 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  15 happyReduction_34
happyReduction_34 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  15 happyReduction_35
happyReduction_35 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  15 happyReduction_36
happyReduction_36 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  15 happyReduction_38
happyReduction_38 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_3  15 happyReduction_39
happyReduction_39 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_39 _ _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_3  15 happyReduction_40
happyReduction_40 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_40 _ _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  15 happyReduction_41
happyReduction_41 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Not happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_2  15 happyReduction_42
happyReduction_42 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Neg happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  16 happyReduction_43
happyReduction_43 _
	 =  HappyAbsSyn16
		 (S.Wildcard
	)

happyReduce_44 = happySpecReduce_1  16 happyReduction_44
happyReduction_44 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 (S.Columns happy_var_1
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  17 happyReduction_45
happyReduction_45 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_3  17 happyReduction_46
happyReduction_46 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_3 : happy_var_1
	)
happyReduction_46 _ _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  18 happyReduction_47
happyReduction_47 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 Nothing
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_2  18 happyReduction_48
happyReduction_48 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 happy_var_2
	)
happyReduction_48 _ _  = notHappyAtAll 

happyReduce_49 = happyReduce 6 19 happyReduction_49
happyReduction_49 ((HappyAbsSyn22  happy_var_6) `HappyStk`
	(HappyAbsSyn27  happy_var_5) `HappyStk`
	(HappyAbsSyn24  happy_var_4) `HappyStk`
	(HappyAbsSyn23  happy_var_3) `HappyStk`
	(HappyAbsSyn20  happy_var_2) `HappyStk`
	_ `HappyStk`
	happyRest)
	 = HappyAbsSyn19
		 (S.mkFromClause happy_var_2 happy_var_3 happy_var_4 happy_var_5 happy_var_6
	) `HappyStk` happyRest

happyReduce_50 = happySpecReduce_1  20 happyReduction_50
happyReduction_50 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 ([ happy_var_1 ]
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  20 happyReduction_51
happyReduction_51 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_3 : happy_var_1
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  21 happyReduction_52
happyReduction_52 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn21
		 (S.Table happy_var_1 Nothing
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  21 happyReduction_53
happyReduction_53 (HappyAbsSyn5  happy_var_2)
	(HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn21
		 (S.Table happy_var_1 happy_var_2
	)
happyReduction_53 _ _  = notHappyAtAll 

happyReduce_54 = happySpecReduce_0  22 happyReduction_54
happyReduction_54  =  HappyAbsSyn22
		 (Nothing
	)

happyReduce_55 = happySpecReduce_2  22 happyReduction_55
happyReduction_55 (HappyTerminal ((T.Integer happy_var_2)))
	_
	 =  HappyAbsSyn22
		 (Just happy_var_2
	)
happyReduction_55 _ _  = notHappyAtAll 

happyReduce_56 = happySpecReduce_0  23 happyReduction_56
happyReduction_56  =  HappyAbsSyn23
		 (Nothing
	)

happyReduce_57 = happySpecReduce_2  23 happyReduction_57
happyReduction_57 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn23
		 (Just happy_var_2
	)
happyReduction_57 _ _  = notHappyAtAll 

happyReduce_58 = happySpecReduce_0  24 happyReduction_58
happyReduction_58  =  HappyAbsSyn24
		 (Nothing
	)

happyReduce_59 = happySpecReduce_2  24 happyReduction_59
happyReduction_59 (HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (Just $ S.GroupBy happy_var_2 Nothing
	)
happyReduction_59 _ _  = notHappyAtAll 

happyReduce_60 = happySpecReduce_3  24 happyReduction_60
happyReduction_60 (HappyAbsSyn26  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn24
		 (Just $ S.GroupBy happy_var_2 (Just happy_var_3)
	)
happyReduction_60 _ _ _  = notHappyAtAll 

happyReduce_61 = happySpecReduce_1  25 happyReduction_61
happyReduction_61 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn25
		 ([ happy_var_1 ]
	)
happyReduction_61 _  = notHappyAtAll 

happyReduce_62 = happySpecReduce_1  25 happyReduction_62
happyReduction_62 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn25
		 ([ happy_var_1 ]
	)
happyReduction_62 _  = notHappyAtAll 

happyReduce_63 = happySpecReduce_3  25 happyReduction_63
happyReduction_63 (HappyTerminal (T.Identifier happy_var_3))
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_3 : happy_var_1
	)
happyReduction_63 _ _ _  = notHappyAtAll 

happyReduce_64 = happySpecReduce_3  25 happyReduction_64
happyReduction_64 (HappyTerminal (T.Dotwalk happy_var_3))
	_
	(HappyAbsSyn25  happy_var_1)
	 =  HappyAbsSyn25
		 (happy_var_3 : happy_var_1
	)
happyReduction_64 _ _ _  = notHappyAtAll 

happyReduce_65 = happySpecReduce_2  26 happyReduction_65
happyReduction_65 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn26
		 (S.Having happy_var_2
	)
happyReduction_65 _ _  = notHappyAtAll 

happyReduce_66 = happySpecReduce_0  27 happyReduction_66
happyReduction_66  =  HappyAbsSyn27
		 (Nothing
	)

happyReduce_67 = happySpecReduce_2  27 happyReduction_67
happyReduction_67 (HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (Just $ S.OrderBy happy_var_2 Nothing
	)
happyReduction_67 _ _  = notHappyAtAll 

happyReduce_68 = happySpecReduce_3  27 happyReduction_68
happyReduction_68 (HappyAbsSyn28  happy_var_3)
	(HappyAbsSyn25  happy_var_2)
	_
	 =  HappyAbsSyn27
		 (Just $ S.OrderBy happy_var_2 (Just happy_var_3)
	)
happyReduction_68 _ _ _  = notHappyAtAll 

happyReduce_69 = happySpecReduce_1  28 happyReduction_69
happyReduction_69 _
	 =  HappyAbsSyn28
		 (S.Ascending
	)

happyReduce_70 = happySpecReduce_1  28 happyReduction_70
happyReduction_70 _
	 =  HappyAbsSyn28
		 (S.Descending
	)

happyNewToken action sts stk [] =
	action 77 77 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.Select -> cont 29;
	T.From -> cont 30;
	T.Where -> cont 31;
	T.GroupBy -> cont 32;
	T.Having -> cont 33;
	T.In -> cont 34;
	T.Distinct -> cont 35;
	T.Limit -> cont 36;
	T.OrderBy -> cont 37;
	T.Ascending -> cont 38;
	T.Descending -> cont 39;
	T.Union -> cont 40;
	T.Intersect -> cont 41;
	T.All -> cont 42;
	T.Left -> cont 43;
	T.Right -> cont 44;
	T.Inner -> cont 45;
	T.Outer -> cont 46;
	T.Natural -> cont 47;
	T.Join -> cont 48;
	T.On -> cont 49;
	T.Plus -> cont 50;
	T.Minus -> cont 51;
	T.Asterisk -> cont 52;
	T.FloatDivide -> cont 53;
	T.Modulo -> cont 54;
	T.Equals -> cont 55;
	T.NotEquals -> cont 56;
	T.LT -> cont 57;
	T.LTE -> cont 58;
	T.GT -> cont 59;
	T.GTE -> cont 60;
	T.Not -> cont 61;
	T.And -> cont 62;
	T.Or -> cont 63;
	T.As -> cont 64;
	T.Identifier happy_dollar_dollar -> cont 65;
	T.LeftParen -> cont 66;
	T.RightParen -> cont 67;
	T.Comma -> cont 68;
	T.BlockComment happy_dollar_dollar -> cont 69;
	T.Dotwalk happy_dollar_dollar -> cont 70;
	(T.Integer happy_dollar_dollar) -> cont 71;
	(T.Float happy_dollar_dollar) -> cont 72;
	(T.String happy_dollar_dollar) -> cont 73;
	(T.TrueVal) -> cont 74;
	(T.FalseVal) -> cont 75;
	(T.Null ) -> cont 76;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 77 tk tks = happyError' (tks, explist)
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
