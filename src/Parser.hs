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
	| HappyAbsSyn14 (S.BinaryOp)
	| HappyAbsSyn15 (S.UnaryOp)
	| HappyAbsSyn16 (S.SelectType)
	| HappyAbsSyn17 ([ S.Column ])
	| HappyAbsSyn18 (S.Column)
	| HappyAbsSyn19 (String)
	| HappyAbsSyn20 ([S.Table])
	| HappyAbsSyn21 ([ S.Table ])
	| HappyAbsSyn22 (S.Table)

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
 action_80 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
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
 happyReduce_51 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,342) ([0,192,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,34822,2033,0,0,0,0,0,0,0,0,0,0,0,0,16,0,0,0,16384,0,0,0,0,0,0,0,0,768,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,63488,1983,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,12288,0,0,0,64,64561,0,0,0,0,0,0,0,16400,16140,0,0,0,1024,0,0,0,4100,4035,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65024,1135,0,0,0,0,1,0,0,256,61636,3,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,4,0,0,0,0,0,0,0,4100,4067,0,0,0,0,0,0,0,50177,1008,0,0,128,63586,1,0,16384,12544,252,0,0,32800,32280,0,0,4096,3136,63,0,0,8200,8070,0,0,1024,49936,15,0,0,34818,2017,0,0,256,61636,3,0,32768,25088,504,0,0,64,64561,0,0,8192,6272,126,0,0,16400,16140,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65280,55,0,0,0,0,3,0,0,0,0,0,0,0,0,0,0,0,32800,32280,0,0,63488,447,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","Alias","Null","True","False","String","Number","Primitive","Expr","Args","BinaryOp","UnaryOp","Select","Columns","Column","Name","From","Tables","Table","select","from","where","groupBy","having","in","distinct","limit","orderBy","asc","desc","union","intersect","all","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","'('","')'","','","bc","dotwalk","integer","float","string","true","false","null","%eof"]
        bit_start = st * 71
        bit_end = (st + 1) * 71
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..70]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (23) = happyShift action_3
action_0 (24) = happyShift action_6
action_0 (4) = happyGoto action_4
action_0 (16) = happyGoto action_2
action_0 (20) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (23) = happyShift action_3
action_1 (16) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (45) = happyShift action_22
action_3 (46) = happyShift action_23
action_3 (55) = happyShift action_24
action_3 (59) = happyShift action_25
action_3 (60) = happyShift action_26
action_3 (64) = happyShift action_27
action_3 (65) = happyShift action_28
action_3 (66) = happyShift action_29
action_3 (67) = happyShift action_30
action_3 (68) = happyShift action_31
action_3 (69) = happyShift action_32
action_3 (70) = happyShift action_33
action_3 (6) = happyGoto action_10
action_3 (7) = happyGoto action_11
action_3 (8) = happyGoto action_12
action_3 (9) = happyGoto action_13
action_3 (10) = happyGoto action_14
action_3 (11) = happyGoto action_15
action_3 (12) = happyGoto action_16
action_3 (14) = happyGoto action_17
action_3 (15) = happyGoto action_18
action_3 (17) = happyGoto action_19
action_3 (18) = happyGoto action_20
action_3 (19) = happyGoto action_21
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (71) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_2

action_6 (59) = happyShift action_9
action_6 (21) = happyGoto action_7
action_6 (22) = happyGoto action_8
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (62) = happyShift action_58
action_7 _ = happyReduce_47

action_8 _ = happyReduce_48

action_9 (58) = happyShift action_40
action_9 (59) = happyShift action_41
action_9 (5) = happyGoto action_57
action_9 _ = happyReduce_50

action_10 _ = happyReduce_11

action_11 _ = happyReduce_12

action_12 _ = happyReduce_13

action_13 _ = happyReduce_14

action_14 _ = happyReduce_15

action_15 _ = happyReduce_17

action_16 (44) = happyShift action_44
action_16 (45) = happyShift action_45
action_16 (46) = happyShift action_46
action_16 (47) = happyShift action_47
action_16 (48) = happyShift action_48
action_16 (49) = happyShift action_49
action_16 (50) = happyShift action_50
action_16 (51) = happyShift action_51
action_16 (52) = happyShift action_52
action_16 (53) = happyShift action_53
action_16 (54) = happyShift action_54
action_16 (56) = happyShift action_55
action_16 (57) = happyShift action_56
action_16 (58) = happyShift action_40
action_16 (59) = happyShift action_41
action_16 (5) = happyGoto action_43
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_19

action_18 _ = happyReduce_20

action_19 (62) = happyShift action_42
action_19 _ = happyReduce_39

action_20 _ = happyReduce_40

action_21 (58) = happyShift action_40
action_21 (59) = happyShift action_41
action_21 (5) = happyGoto action_39
action_21 _ = happyReduce_42

action_22 (45) = happyShift action_22
action_22 (55) = happyShift action_24
action_22 (59) = happyShift action_35
action_22 (60) = happyShift action_26
action_22 (65) = happyShift action_28
action_22 (66) = happyShift action_29
action_22 (67) = happyShift action_30
action_22 (68) = happyShift action_31
action_22 (69) = happyShift action_32
action_22 (70) = happyShift action_33
action_22 (6) = happyGoto action_10
action_22 (7) = happyGoto action_11
action_22 (8) = happyGoto action_12
action_22 (9) = happyGoto action_13
action_22 (10) = happyGoto action_14
action_22 (11) = happyGoto action_15
action_22 (12) = happyGoto action_38
action_22 (14) = happyGoto action_17
action_22 (15) = happyGoto action_18
action_22 _ = happyFail (happyExpListPerState 22)

action_23 _ = happyReduce_38

action_24 (45) = happyShift action_22
action_24 (55) = happyShift action_24
action_24 (59) = happyShift action_35
action_24 (60) = happyShift action_26
action_24 (65) = happyShift action_28
action_24 (66) = happyShift action_29
action_24 (67) = happyShift action_30
action_24 (68) = happyShift action_31
action_24 (69) = happyShift action_32
action_24 (70) = happyShift action_33
action_24 (6) = happyGoto action_10
action_24 (7) = happyGoto action_11
action_24 (8) = happyGoto action_12
action_24 (9) = happyGoto action_13
action_24 (10) = happyGoto action_14
action_24 (11) = happyGoto action_15
action_24 (12) = happyGoto action_37
action_24 (14) = happyGoto action_17
action_24 (15) = happyGoto action_18
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (60) = happyShift action_36
action_25 _ = happyReduce_45

action_26 (45) = happyShift action_22
action_26 (55) = happyShift action_24
action_26 (59) = happyShift action_35
action_26 (60) = happyShift action_26
action_26 (65) = happyShift action_28
action_26 (66) = happyShift action_29
action_26 (67) = happyShift action_30
action_26 (68) = happyShift action_31
action_26 (69) = happyShift action_32
action_26 (70) = happyShift action_33
action_26 (6) = happyGoto action_10
action_26 (7) = happyGoto action_11
action_26 (8) = happyGoto action_12
action_26 (9) = happyGoto action_13
action_26 (10) = happyGoto action_14
action_26 (11) = happyGoto action_15
action_26 (12) = happyGoto action_34
action_26 (14) = happyGoto action_17
action_26 (15) = happyGoto action_18
action_26 _ = happyFail (happyExpListPerState 26)

action_27 _ = happyReduce_46

action_28 _ = happyReduce_9

action_29 _ = happyReduce_10

action_30 _ = happyReduce_8

action_31 _ = happyReduce_6

action_32 _ = happyReduce_7

action_33 _ = happyReduce_5

action_34 (44) = happyShift action_44
action_34 (45) = happyShift action_45
action_34 (46) = happyShift action_46
action_34 (47) = happyShift action_47
action_34 (48) = happyShift action_48
action_34 (49) = happyShift action_49
action_34 (50) = happyShift action_50
action_34 (51) = happyShift action_51
action_34 (52) = happyShift action_52
action_34 (53) = happyShift action_53
action_34 (54) = happyShift action_54
action_34 (56) = happyShift action_55
action_34 (57) = happyShift action_56
action_34 (61) = happyShift action_77
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (60) = happyShift action_36
action_35 _ = happyFail (happyExpListPerState 35)

action_36 (45) = happyShift action_22
action_36 (55) = happyShift action_24
action_36 (59) = happyShift action_35
action_36 (60) = happyShift action_26
action_36 (65) = happyShift action_28
action_36 (66) = happyShift action_29
action_36 (67) = happyShift action_30
action_36 (68) = happyShift action_31
action_36 (69) = happyShift action_32
action_36 (70) = happyShift action_33
action_36 (6) = happyGoto action_10
action_36 (7) = happyGoto action_11
action_36 (8) = happyGoto action_12
action_36 (9) = happyGoto action_13
action_36 (10) = happyGoto action_14
action_36 (11) = happyGoto action_15
action_36 (12) = happyGoto action_75
action_36 (13) = happyGoto action_76
action_36 (14) = happyGoto action_17
action_36 (15) = happyGoto action_18
action_36 _ = happyFail (happyExpListPerState 36)

action_37 (44) = happyShift action_44
action_37 (45) = happyShift action_45
action_37 (46) = happyShift action_46
action_37 (47) = happyShift action_47
action_37 (48) = happyShift action_48
action_37 (49) = happyShift action_49
action_37 (50) = happyShift action_50
action_37 (51) = happyShift action_51
action_37 (52) = happyShift action_52
action_37 (53) = happyShift action_53
action_37 (54) = happyShift action_54
action_37 (56) = happyShift action_55
action_37 (57) = happyShift action_56
action_37 _ = happyReduce_36

action_38 (44) = happyShift action_44
action_38 (45) = happyShift action_45
action_38 (46) = happyShift action_46
action_38 (47) = happyShift action_47
action_38 (48) = happyShift action_48
action_38 (49) = happyShift action_49
action_38 (50) = happyShift action_50
action_38 (51) = happyShift action_51
action_38 (52) = happyShift action_52
action_38 (53) = happyShift action_53
action_38 (54) = happyShift action_54
action_38 (56) = happyShift action_55
action_38 (57) = happyShift action_56
action_38 _ = happyReduce_37

action_39 _ = happyReduce_43

action_40 (59) = happyShift action_74
action_40 _ = happyFail (happyExpListPerState 40)

action_41 _ = happyReduce_3

action_42 (45) = happyShift action_22
action_42 (55) = happyShift action_24
action_42 (59) = happyShift action_25
action_42 (60) = happyShift action_26
action_42 (64) = happyShift action_27
action_42 (65) = happyShift action_28
action_42 (66) = happyShift action_29
action_42 (67) = happyShift action_30
action_42 (68) = happyShift action_31
action_42 (69) = happyShift action_32
action_42 (70) = happyShift action_33
action_42 (6) = happyGoto action_10
action_42 (7) = happyGoto action_11
action_42 (8) = happyGoto action_12
action_42 (9) = happyGoto action_13
action_42 (10) = happyGoto action_14
action_42 (11) = happyGoto action_15
action_42 (12) = happyGoto action_16
action_42 (14) = happyGoto action_17
action_42 (15) = happyGoto action_18
action_42 (18) = happyGoto action_73
action_42 (19) = happyGoto action_21
action_42 _ = happyFail (happyExpListPerState 42)

action_43 _ = happyReduce_44

action_44 (45) = happyShift action_22
action_44 (55) = happyShift action_24
action_44 (59) = happyShift action_35
action_44 (60) = happyShift action_26
action_44 (65) = happyShift action_28
action_44 (66) = happyShift action_29
action_44 (67) = happyShift action_30
action_44 (68) = happyShift action_31
action_44 (69) = happyShift action_32
action_44 (70) = happyShift action_33
action_44 (6) = happyGoto action_10
action_44 (7) = happyGoto action_11
action_44 (8) = happyGoto action_12
action_44 (9) = happyGoto action_13
action_44 (10) = happyGoto action_14
action_44 (11) = happyGoto action_15
action_44 (12) = happyGoto action_72
action_44 (14) = happyGoto action_17
action_44 (15) = happyGoto action_18
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (45) = happyShift action_22
action_45 (55) = happyShift action_24
action_45 (59) = happyShift action_35
action_45 (60) = happyShift action_26
action_45 (65) = happyShift action_28
action_45 (66) = happyShift action_29
action_45 (67) = happyShift action_30
action_45 (68) = happyShift action_31
action_45 (69) = happyShift action_32
action_45 (70) = happyShift action_33
action_45 (6) = happyGoto action_10
action_45 (7) = happyGoto action_11
action_45 (8) = happyGoto action_12
action_45 (9) = happyGoto action_13
action_45 (10) = happyGoto action_14
action_45 (11) = happyGoto action_15
action_45 (12) = happyGoto action_71
action_45 (14) = happyGoto action_17
action_45 (15) = happyGoto action_18
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (45) = happyShift action_22
action_46 (55) = happyShift action_24
action_46 (59) = happyShift action_35
action_46 (60) = happyShift action_26
action_46 (65) = happyShift action_28
action_46 (66) = happyShift action_29
action_46 (67) = happyShift action_30
action_46 (68) = happyShift action_31
action_46 (69) = happyShift action_32
action_46 (70) = happyShift action_33
action_46 (6) = happyGoto action_10
action_46 (7) = happyGoto action_11
action_46 (8) = happyGoto action_12
action_46 (9) = happyGoto action_13
action_46 (10) = happyGoto action_14
action_46 (11) = happyGoto action_15
action_46 (12) = happyGoto action_70
action_46 (14) = happyGoto action_17
action_46 (15) = happyGoto action_18
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (45) = happyShift action_22
action_47 (55) = happyShift action_24
action_47 (59) = happyShift action_35
action_47 (60) = happyShift action_26
action_47 (65) = happyShift action_28
action_47 (66) = happyShift action_29
action_47 (67) = happyShift action_30
action_47 (68) = happyShift action_31
action_47 (69) = happyShift action_32
action_47 (70) = happyShift action_33
action_47 (6) = happyGoto action_10
action_47 (7) = happyGoto action_11
action_47 (8) = happyGoto action_12
action_47 (9) = happyGoto action_13
action_47 (10) = happyGoto action_14
action_47 (11) = happyGoto action_15
action_47 (12) = happyGoto action_69
action_47 (14) = happyGoto action_17
action_47 (15) = happyGoto action_18
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (45) = happyShift action_22
action_48 (55) = happyShift action_24
action_48 (59) = happyShift action_35
action_48 (60) = happyShift action_26
action_48 (65) = happyShift action_28
action_48 (66) = happyShift action_29
action_48 (67) = happyShift action_30
action_48 (68) = happyShift action_31
action_48 (69) = happyShift action_32
action_48 (70) = happyShift action_33
action_48 (6) = happyGoto action_10
action_48 (7) = happyGoto action_11
action_48 (8) = happyGoto action_12
action_48 (9) = happyGoto action_13
action_48 (10) = happyGoto action_14
action_48 (11) = happyGoto action_15
action_48 (12) = happyGoto action_68
action_48 (14) = happyGoto action_17
action_48 (15) = happyGoto action_18
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (45) = happyShift action_22
action_49 (55) = happyShift action_24
action_49 (59) = happyShift action_35
action_49 (60) = happyShift action_26
action_49 (65) = happyShift action_28
action_49 (66) = happyShift action_29
action_49 (67) = happyShift action_30
action_49 (68) = happyShift action_31
action_49 (69) = happyShift action_32
action_49 (70) = happyShift action_33
action_49 (6) = happyGoto action_10
action_49 (7) = happyGoto action_11
action_49 (8) = happyGoto action_12
action_49 (9) = happyGoto action_13
action_49 (10) = happyGoto action_14
action_49 (11) = happyGoto action_15
action_49 (12) = happyGoto action_67
action_49 (14) = happyGoto action_17
action_49 (15) = happyGoto action_18
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (45) = happyShift action_22
action_50 (55) = happyShift action_24
action_50 (59) = happyShift action_35
action_50 (60) = happyShift action_26
action_50 (65) = happyShift action_28
action_50 (66) = happyShift action_29
action_50 (67) = happyShift action_30
action_50 (68) = happyShift action_31
action_50 (69) = happyShift action_32
action_50 (70) = happyShift action_33
action_50 (6) = happyGoto action_10
action_50 (7) = happyGoto action_11
action_50 (8) = happyGoto action_12
action_50 (9) = happyGoto action_13
action_50 (10) = happyGoto action_14
action_50 (11) = happyGoto action_15
action_50 (12) = happyGoto action_66
action_50 (14) = happyGoto action_17
action_50 (15) = happyGoto action_18
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (45) = happyShift action_22
action_51 (55) = happyShift action_24
action_51 (59) = happyShift action_35
action_51 (60) = happyShift action_26
action_51 (65) = happyShift action_28
action_51 (66) = happyShift action_29
action_51 (67) = happyShift action_30
action_51 (68) = happyShift action_31
action_51 (69) = happyShift action_32
action_51 (70) = happyShift action_33
action_51 (6) = happyGoto action_10
action_51 (7) = happyGoto action_11
action_51 (8) = happyGoto action_12
action_51 (9) = happyGoto action_13
action_51 (10) = happyGoto action_14
action_51 (11) = happyGoto action_15
action_51 (12) = happyGoto action_65
action_51 (14) = happyGoto action_17
action_51 (15) = happyGoto action_18
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (45) = happyShift action_22
action_52 (55) = happyShift action_24
action_52 (59) = happyShift action_35
action_52 (60) = happyShift action_26
action_52 (65) = happyShift action_28
action_52 (66) = happyShift action_29
action_52 (67) = happyShift action_30
action_52 (68) = happyShift action_31
action_52 (69) = happyShift action_32
action_52 (70) = happyShift action_33
action_52 (6) = happyGoto action_10
action_52 (7) = happyGoto action_11
action_52 (8) = happyGoto action_12
action_52 (9) = happyGoto action_13
action_52 (10) = happyGoto action_14
action_52 (11) = happyGoto action_15
action_52 (12) = happyGoto action_64
action_52 (14) = happyGoto action_17
action_52 (15) = happyGoto action_18
action_52 _ = happyFail (happyExpListPerState 52)

action_53 (45) = happyShift action_22
action_53 (55) = happyShift action_24
action_53 (59) = happyShift action_35
action_53 (60) = happyShift action_26
action_53 (65) = happyShift action_28
action_53 (66) = happyShift action_29
action_53 (67) = happyShift action_30
action_53 (68) = happyShift action_31
action_53 (69) = happyShift action_32
action_53 (70) = happyShift action_33
action_53 (6) = happyGoto action_10
action_53 (7) = happyGoto action_11
action_53 (8) = happyGoto action_12
action_53 (9) = happyGoto action_13
action_53 (10) = happyGoto action_14
action_53 (11) = happyGoto action_15
action_53 (12) = happyGoto action_63
action_53 (14) = happyGoto action_17
action_53 (15) = happyGoto action_18
action_53 _ = happyFail (happyExpListPerState 53)

action_54 (45) = happyShift action_22
action_54 (55) = happyShift action_24
action_54 (59) = happyShift action_35
action_54 (60) = happyShift action_26
action_54 (65) = happyShift action_28
action_54 (66) = happyShift action_29
action_54 (67) = happyShift action_30
action_54 (68) = happyShift action_31
action_54 (69) = happyShift action_32
action_54 (70) = happyShift action_33
action_54 (6) = happyGoto action_10
action_54 (7) = happyGoto action_11
action_54 (8) = happyGoto action_12
action_54 (9) = happyGoto action_13
action_54 (10) = happyGoto action_14
action_54 (11) = happyGoto action_15
action_54 (12) = happyGoto action_62
action_54 (14) = happyGoto action_17
action_54 (15) = happyGoto action_18
action_54 _ = happyFail (happyExpListPerState 54)

action_55 (45) = happyShift action_22
action_55 (55) = happyShift action_24
action_55 (59) = happyShift action_35
action_55 (60) = happyShift action_26
action_55 (65) = happyShift action_28
action_55 (66) = happyShift action_29
action_55 (67) = happyShift action_30
action_55 (68) = happyShift action_31
action_55 (69) = happyShift action_32
action_55 (70) = happyShift action_33
action_55 (6) = happyGoto action_10
action_55 (7) = happyGoto action_11
action_55 (8) = happyGoto action_12
action_55 (9) = happyGoto action_13
action_55 (10) = happyGoto action_14
action_55 (11) = happyGoto action_15
action_55 (12) = happyGoto action_61
action_55 (14) = happyGoto action_17
action_55 (15) = happyGoto action_18
action_55 _ = happyFail (happyExpListPerState 55)

action_56 (45) = happyShift action_22
action_56 (55) = happyShift action_24
action_56 (59) = happyShift action_35
action_56 (60) = happyShift action_26
action_56 (65) = happyShift action_28
action_56 (66) = happyShift action_29
action_56 (67) = happyShift action_30
action_56 (68) = happyShift action_31
action_56 (69) = happyShift action_32
action_56 (70) = happyShift action_33
action_56 (6) = happyGoto action_10
action_56 (7) = happyGoto action_11
action_56 (8) = happyGoto action_12
action_56 (9) = happyGoto action_13
action_56 (10) = happyGoto action_14
action_56 (11) = happyGoto action_15
action_56 (12) = happyGoto action_60
action_56 (14) = happyGoto action_17
action_56 (15) = happyGoto action_18
action_56 _ = happyFail (happyExpListPerState 56)

action_57 _ = happyReduce_51

action_58 (59) = happyShift action_9
action_58 (22) = happyGoto action_59
action_58 _ = happyFail (happyExpListPerState 58)

action_59 _ = happyReduce_49

action_60 (44) = happyShift action_44
action_60 (45) = happyShift action_45
action_60 (46) = happyShift action_46
action_60 (47) = happyShift action_47
action_60 (48) = happyShift action_48
action_60 (49) = happyShift action_49
action_60 (50) = happyShift action_50
action_60 (51) = happyShift action_51
action_60 (52) = happyShift action_52
action_60 (53) = happyShift action_53
action_60 (54) = happyShift action_54
action_60 (56) = happyShift action_55
action_60 (57) = happyShift action_56
action_60 _ = happyReduce_35

action_61 (44) = happyShift action_44
action_61 (45) = happyShift action_45
action_61 (46) = happyShift action_46
action_61 (47) = happyShift action_47
action_61 (48) = happyShift action_48
action_61 (49) = happyShift action_49
action_61 (50) = happyShift action_50
action_61 (51) = happyShift action_51
action_61 (52) = happyShift action_52
action_61 (53) = happyShift action_53
action_61 (54) = happyShift action_54
action_61 (56) = happyShift action_55
action_61 (57) = happyShift action_56
action_61 _ = happyReduce_34

action_62 (44) = happyShift action_44
action_62 (45) = happyShift action_45
action_62 (46) = happyShift action_46
action_62 (47) = happyShift action_47
action_62 (48) = happyShift action_48
action_62 (49) = happyShift action_49
action_62 (50) = happyShift action_50
action_62 (51) = happyShift action_51
action_62 (52) = happyShift action_52
action_62 (53) = happyShift action_53
action_62 (54) = happyShift action_54
action_62 (56) = happyShift action_55
action_62 (57) = happyShift action_56
action_62 _ = happyReduce_33

action_63 (44) = happyShift action_44
action_63 (45) = happyShift action_45
action_63 (46) = happyShift action_46
action_63 (47) = happyShift action_47
action_63 (48) = happyShift action_48
action_63 (49) = happyShift action_49
action_63 (50) = happyShift action_50
action_63 (51) = happyShift action_51
action_63 (52) = happyShift action_52
action_63 (53) = happyShift action_53
action_63 (54) = happyShift action_54
action_63 (56) = happyShift action_55
action_63 (57) = happyShift action_56
action_63 _ = happyReduce_32

action_64 (44) = happyShift action_44
action_64 (45) = happyShift action_45
action_64 (46) = happyShift action_46
action_64 (47) = happyShift action_47
action_64 (48) = happyShift action_48
action_64 (49) = happyShift action_49
action_64 (50) = happyShift action_50
action_64 (51) = happyShift action_51
action_64 (52) = happyShift action_52
action_64 (53) = happyShift action_53
action_64 (54) = happyShift action_54
action_64 (56) = happyShift action_55
action_64 (57) = happyShift action_56
action_64 _ = happyReduce_31

action_65 (44) = happyShift action_44
action_65 (45) = happyShift action_45
action_65 (46) = happyShift action_46
action_65 (47) = happyShift action_47
action_65 (48) = happyShift action_48
action_65 (49) = happyShift action_49
action_65 (50) = happyShift action_50
action_65 (51) = happyShift action_51
action_65 (52) = happyShift action_52
action_65 (53) = happyShift action_53
action_65 (54) = happyShift action_54
action_65 (56) = happyShift action_55
action_65 (57) = happyShift action_56
action_65 _ = happyReduce_30

action_66 (44) = happyShift action_44
action_66 (45) = happyShift action_45
action_66 (46) = happyShift action_46
action_66 (47) = happyShift action_47
action_66 (48) = happyShift action_48
action_66 (49) = happyShift action_49
action_66 (50) = happyShift action_50
action_66 (51) = happyShift action_51
action_66 (52) = happyShift action_52
action_66 (53) = happyShift action_53
action_66 (54) = happyShift action_54
action_66 (56) = happyShift action_55
action_66 (57) = happyShift action_56
action_66 _ = happyReduce_29

action_67 (44) = happyShift action_44
action_67 (45) = happyShift action_45
action_67 (46) = happyShift action_46
action_67 (47) = happyShift action_47
action_67 (48) = happyShift action_48
action_67 (49) = happyShift action_49
action_67 (50) = happyShift action_50
action_67 (51) = happyShift action_51
action_67 (52) = happyShift action_52
action_67 (53) = happyShift action_53
action_67 (54) = happyShift action_54
action_67 (56) = happyShift action_55
action_67 (57) = happyShift action_56
action_67 _ = happyReduce_28

action_68 (44) = happyShift action_44
action_68 (45) = happyShift action_45
action_68 (46) = happyShift action_46
action_68 (47) = happyShift action_47
action_68 (48) = happyShift action_48
action_68 (49) = happyShift action_49
action_68 (50) = happyShift action_50
action_68 (51) = happyShift action_51
action_68 (52) = happyShift action_52
action_68 (53) = happyShift action_53
action_68 (54) = happyShift action_54
action_68 (56) = happyShift action_55
action_68 (57) = happyShift action_56
action_68 _ = happyReduce_27

action_69 (44) = happyShift action_44
action_69 (45) = happyShift action_45
action_69 (46) = happyShift action_46
action_69 (47) = happyShift action_47
action_69 (48) = happyShift action_48
action_69 (49) = happyShift action_49
action_69 (50) = happyShift action_50
action_69 (51) = happyShift action_51
action_69 (52) = happyShift action_52
action_69 (53) = happyShift action_53
action_69 (54) = happyShift action_54
action_69 (56) = happyShift action_55
action_69 (57) = happyShift action_56
action_69 _ = happyReduce_26

action_70 (44) = happyShift action_44
action_70 (45) = happyShift action_45
action_70 (46) = happyShift action_46
action_70 (47) = happyShift action_47
action_70 (48) = happyShift action_48
action_70 (49) = happyShift action_49
action_70 (50) = happyShift action_50
action_70 (51) = happyShift action_51
action_70 (52) = happyShift action_52
action_70 (53) = happyShift action_53
action_70 (54) = happyShift action_54
action_70 (56) = happyShift action_55
action_70 (57) = happyShift action_56
action_70 _ = happyReduce_25

action_71 (44) = happyShift action_44
action_71 (45) = happyShift action_45
action_71 (46) = happyShift action_46
action_71 (47) = happyShift action_47
action_71 (48) = happyShift action_48
action_71 (49) = happyShift action_49
action_71 (50) = happyShift action_50
action_71 (51) = happyShift action_51
action_71 (52) = happyShift action_52
action_71 (53) = happyShift action_53
action_71 (54) = happyShift action_54
action_71 (56) = happyShift action_55
action_71 (57) = happyShift action_56
action_71 _ = happyReduce_24

action_72 (44) = happyShift action_44
action_72 (45) = happyShift action_45
action_72 (46) = happyShift action_46
action_72 (47) = happyShift action_47
action_72 (48) = happyShift action_48
action_72 (49) = happyShift action_49
action_72 (50) = happyShift action_50
action_72 (51) = happyShift action_51
action_72 (52) = happyShift action_52
action_72 (53) = happyShift action_53
action_72 (54) = happyShift action_54
action_72 (56) = happyShift action_55
action_72 (57) = happyShift action_56
action_72 _ = happyReduce_23

action_73 _ = happyReduce_41

action_74 _ = happyReduce_4

action_75 (44) = happyShift action_44
action_75 (45) = happyShift action_45
action_75 (46) = happyShift action_46
action_75 (47) = happyShift action_47
action_75 (48) = happyShift action_48
action_75 (49) = happyShift action_49
action_75 (50) = happyShift action_50
action_75 (51) = happyShift action_51
action_75 (52) = happyShift action_52
action_75 (53) = happyShift action_53
action_75 (54) = happyShift action_54
action_75 (56) = happyShift action_55
action_75 (57) = happyShift action_56
action_75 _ = happyReduce_21

action_76 (61) = happyShift action_78
action_76 (62) = happyShift action_79
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_16

action_78 _ = happyReduce_18

action_79 (45) = happyShift action_22
action_79 (55) = happyShift action_24
action_79 (59) = happyShift action_35
action_79 (60) = happyShift action_26
action_79 (65) = happyShift action_28
action_79 (66) = happyShift action_29
action_79 (67) = happyShift action_30
action_79 (68) = happyShift action_31
action_79 (69) = happyShift action_32
action_79 (70) = happyShift action_33
action_79 (6) = happyGoto action_10
action_79 (7) = happyGoto action_11
action_79 (8) = happyGoto action_12
action_79 (9) = happyGoto action_13
action_79 (10) = happyGoto action_14
action_79 (11) = happyGoto action_15
action_79 (12) = happyGoto action_80
action_79 (14) = happyGoto action_17
action_79 (15) = happyGoto action_18
action_79 _ = happyFail (happyExpListPerState 79)

action_80 (44) = happyShift action_44
action_80 (45) = happyShift action_45
action_80 (46) = happyShift action_46
action_80 (47) = happyShift action_47
action_80 (48) = happyShift action_48
action_80 (49) = happyShift action_49
action_80 (50) = happyShift action_50
action_80 (51) = happyShift action_51
action_80 (52) = happyShift action_52
action_80 (53) = happyShift action_53
action_80 (54) = happyShift action_54
action_80 (56) = happyShift action_55
action_80 (57) = happyShift action_56
action_80 _ = happyReduce_22

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn4
		 (S.Select happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn4
		 (S.From happy_var_1
	)
happyReduction_2 _  = notHappyAtAll 

happyReduce_3 = happySpecReduce_1  5 happyReduction_3
happyReduction_3 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn5
		 (Just happy_var_1
	)
happyReduction_3 _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_2  5 happyReduction_4
happyReduction_4 (HappyTerminal (T.Identifier happy_var_2))
	_
	 =  HappyAbsSyn5
		 (Just happy_var_2
	)
happyReduction_4 _ _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_1  6 happyReduction_5
happyReduction_5 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.Null)
	)

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.TrueVal)
	)

happyReduce_7 = happySpecReduce_1  8 happyReduction_7
happyReduction_7 _
	 =  HappyAbsSyn6
		 ((S.Boolean S.FalseVal)
	)

happyReduce_8 = happySpecReduce_1  9 happyReduction_8
happyReduction_8 (HappyTerminal (T.Constant (T.String happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.String happy_var_1)
	)
happyReduction_8 _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  10 happyReduction_9
happyReduction_9 (HappyTerminal (T.Constant (T.Integer happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.Number happy_var_1)
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_1  10 happyReduction_10
happyReduction_10 (HappyTerminal (T.Constant (T.Float happy_var_1)))
	 =  HappyAbsSyn6
		 ((S.Number happy_var_1)
	)
happyReduction_10 _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  11 happyReduction_11
happyReduction_11 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  11 happyReduction_12
happyReduction_12 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  11 happyReduction_13
happyReduction_13 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_1
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

happyReduce_16 = happySpecReduce_3  12 happyReduction_16
happyReduction_16 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  12 happyReduction_17
happyReduction_17 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Constant happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happyReduce 4 12 happyReduction_18
happyReduction_18 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (S.Function happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_19 = happySpecReduce_1  12 happyReduction_19
happyReduction_19 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Operator (S.Binary happy_var_1)
	)
happyReduction_19 _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Operator (S.Unary happy_var_1)
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  13 happyReduction_21
happyReduction_21 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn13
		 ([ happy_var_1 ]
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 ((happy_var_3 : happy_var_1)
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  14 happyReduction_23
happyReduction_23 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  14 happyReduction_24
happyReduction_24 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  14 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  14 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  14 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  14 happyReduction_28
happyReduction_28 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  14 happyReduction_29
happyReduction_29 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  14 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  14 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  14 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  14 happyReduction_33
happyReduction_33 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  14 happyReduction_34
happyReduction_34 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  14 happyReduction_35
happyReduction_35 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_2  15 happyReduction_36
happyReduction_36 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Not happy_var_2
	)
happyReduction_36 _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_2  15 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Neg happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  16 happyReduction_38
happyReduction_38 _
	_
	 =  HappyAbsSyn16
		 (S.Wildcard
	)

happyReduce_39 = happySpecReduce_2  16 happyReduction_39
happyReduction_39 (HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (S.Columns happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_1  17 happyReduction_40
happyReduction_40 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_40 _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_3  17 happyReduction_41
happyReduction_41 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_3 : happy_var_1
	)
happyReduction_41 _ _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  18 happyReduction_42
happyReduction_42 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 Nothing
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_2  18 happyReduction_43
happyReduction_43 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 happy_var_2
	)
happyReduction_43 _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_2  18 happyReduction_44
happyReduction_44 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Value happy_var_1 happy_var_2
	)
happyReduction_44 _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_1  19 happyReduction_46
happyReduction_46 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn19
		 (happy_var_1
	)
happyReduction_46 _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_2  20 happyReduction_47
happyReduction_47 (HappyAbsSyn21  happy_var_2)
	_
	 =  HappyAbsSyn20
		 (happy_var_2
	)
happyReduction_47 _ _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  21 happyReduction_48
happyReduction_48 (HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn21
		 ([ happy_var_1 ]
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_3  21 happyReduction_49
happyReduction_49 (HappyAbsSyn22  happy_var_3)
	_
	(HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn21
		 (happy_var_3 : happy_var_1
	)
happyReduction_49 _ _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  22 happyReduction_50
happyReduction_50 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn22
		 (S.Table happy_var_1 Nothing
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_2  22 happyReduction_51
happyReduction_51 (HappyAbsSyn5  happy_var_2)
	(HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn22
		 (S.Table happy_var_1 happy_var_2
	)
happyReduction_51 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 71 71 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.Select -> cont 23;
	T.From -> cont 24;
	T.Where -> cont 25;
	T.GroupBy -> cont 26;
	T.Having -> cont 27;
	T.In -> cont 28;
	T.Distinct -> cont 29;
	T.Limit -> cont 30;
	T.OrderBy -> cont 31;
	T.Ascending -> cont 32;
	T.Descending -> cont 33;
	T.Union -> cont 34;
	T.Intersect -> cont 35;
	T.All -> cont 36;
	T.Left -> cont 37;
	T.Right -> cont 38;
	T.Inner -> cont 39;
	T.Outer -> cont 40;
	T.Natural -> cont 41;
	T.Join -> cont 42;
	T.On -> cont 43;
	T.Plus -> cont 44;
	T.Minus -> cont 45;
	T.Asterisk -> cont 46;
	T.FloatDivide -> cont 47;
	T.Modulo -> cont 48;
	T.Equals -> cont 49;
	T.NotEquals -> cont 50;
	T.LT -> cont 51;
	T.LTE -> cont 52;
	T.GT -> cont 53;
	T.GTE -> cont 54;
	T.Not -> cont 55;
	T.And -> cont 56;
	T.Or -> cont 57;
	T.As -> cont 58;
	T.Identifier happy_dollar_dollar -> cont 59;
	T.RightParen -> cont 60;
	T.LeftParen -> cont 61;
	T.Comma -> cont 62;
	T.BlockComment happy_dollar_dollar -> cont 63;
	T.Dotwalk happy_dollar_dollar -> cont 64;
	T.Constant (T.Integer happy_dollar_dollar) -> cont 65;
	T.Constant (T.Float happy_dollar_dollar) -> cont 66;
	T.Constant (T.String happy_dollar_dollar) -> cont 67;
	T.Constant (T.Boolean T.TrueVal) -> cont 68;
	T.Constant (T.Boolean T.FalseVal) -> cont 69;
	T.Constant (T.Boolean T.Null ) -> cont 70;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 71 tk tks = happyError' (tks, explist)
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
parseError _ = error "Parse error"
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
