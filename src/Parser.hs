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
	| HappyAbsSyn15 (S.BinaryOp)
	| HappyAbsSyn16 (S.UnaryOp)
	| HappyAbsSyn17 (S.SelectType)
	| HappyAbsSyn18 ([ S.Column ])
	| HappyAbsSyn19 (S.Column)
	| HappyAbsSyn20 (String)
	| HappyAbsSyn21 ([S.Table])
	| HappyAbsSyn22 ([ S.Table ])
	| HappyAbsSyn23 (S.Table)

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
 action_78 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
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
 happyReduce_53 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,353) ([0,384,0,0,0,32768,0,0,0,0,0,0,0,0,0,0,32864,32536,0,0,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,64,0,0,0,0,0,0,0,0,12,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,3967,0,0,0,0,0,0,0,0,0,0,0,0,0,64,0,0,0,0,0,0,0,32800,32536,0,0,0,0,0,0,0,32800,32536,0,0,0,4096,0,0,0,32800,32536,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32752,35,0,0,8192,6272,127,0,0,0,0,0,0,0,0,0,0,0,32800,32536,0,0,0,0,0,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,8192,6272,127,0,0,32800,32536,0,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,61440,895,0,0,0,0,96,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32800,32536,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","Alias","Null","True","False","String","Number","Primitive","Expr","Args","Arg","BinaryOp","UnaryOp","Select","Columns","Column","Name","From","Tables","Table","select","from","where","groupBy","having","in","distinct","limit","orderBy","asc","desc","union","intersect","all","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","'('","')'","','","bc","dotwalk","integer","float","string","true","false","null","%eof"]
        bit_start = st * 72
        bit_end = (st + 1) * 72
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..71]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (24) = happyShift action_3
action_0 (25) = happyShift action_6
action_0 (4) = happyGoto action_4
action_0 (17) = happyGoto action_2
action_0 (21) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (24) = happyShift action_3
action_1 (17) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (46) = happyShift action_21
action_3 (47) = happyShift action_22
action_3 (56) = happyShift action_23
action_3 (60) = happyShift action_24
action_3 (61) = happyShift action_25
action_3 (65) = happyShift action_26
action_3 (66) = happyShift action_27
action_3 (67) = happyShift action_28
action_3 (68) = happyShift action_29
action_3 (69) = happyShift action_30
action_3 (70) = happyShift action_31
action_3 (71) = happyShift action_32
action_3 (6) = happyGoto action_10
action_3 (7) = happyGoto action_11
action_3 (8) = happyGoto action_12
action_3 (9) = happyGoto action_13
action_3 (10) = happyGoto action_14
action_3 (11) = happyGoto action_15
action_3 (12) = happyGoto action_16
action_3 (15) = happyGoto action_17
action_3 (16) = happyGoto action_18
action_3 (18) = happyGoto action_19
action_3 (19) = happyGoto action_20
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (72) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_2

action_6 (60) = happyShift action_9
action_6 (22) = happyGoto action_7
action_6 (23) = happyGoto action_8
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (63) = happyShift action_55
action_7 _ = happyReduce_49

action_8 _ = happyReduce_50

action_9 (59) = happyShift action_52
action_9 (60) = happyShift action_53
action_9 (5) = happyGoto action_54
action_9 _ = happyReduce_52

action_10 _ = happyReduce_11

action_11 _ = happyReduce_12

action_12 _ = happyReduce_13

action_13 _ = happyReduce_14

action_14 _ = happyReduce_15

action_15 _ = happyReduce_16

action_16 (45) = happyShift action_39
action_16 (46) = happyShift action_40
action_16 (47) = happyShift action_41
action_16 (48) = happyShift action_42
action_16 (49) = happyShift action_43
action_16 (50) = happyShift action_44
action_16 (51) = happyShift action_45
action_16 (52) = happyShift action_46
action_16 (53) = happyShift action_47
action_16 (54) = happyShift action_48
action_16 (55) = happyShift action_49
action_16 (57) = happyShift action_50
action_16 (58) = happyShift action_51
action_16 (59) = happyShift action_52
action_16 (60) = happyShift action_53
action_16 (5) = happyGoto action_38
action_16 _ = happyReduce_45

action_17 _ = happyReduce_20

action_18 _ = happyReduce_21

action_19 (63) = happyShift action_37
action_19 _ = happyReduce_42

action_20 _ = happyReduce_43

action_21 (46) = happyShift action_21
action_21 (56) = happyShift action_23
action_21 (60) = happyShift action_24
action_21 (61) = happyShift action_25
action_21 (65) = happyShift action_26
action_21 (66) = happyShift action_27
action_21 (67) = happyShift action_28
action_21 (68) = happyShift action_29
action_21 (69) = happyShift action_30
action_21 (70) = happyShift action_31
action_21 (71) = happyShift action_32
action_21 (6) = happyGoto action_10
action_21 (7) = happyGoto action_11
action_21 (8) = happyGoto action_12
action_21 (9) = happyGoto action_13
action_21 (10) = happyGoto action_14
action_21 (11) = happyGoto action_15
action_21 (12) = happyGoto action_36
action_21 (15) = happyGoto action_17
action_21 (16) = happyGoto action_18
action_21 _ = happyFail (happyExpListPerState 21)

action_22 _ = happyReduce_41

action_23 (46) = happyShift action_21
action_23 (56) = happyShift action_23
action_23 (60) = happyShift action_24
action_23 (61) = happyShift action_25
action_23 (65) = happyShift action_26
action_23 (66) = happyShift action_27
action_23 (67) = happyShift action_28
action_23 (68) = happyShift action_29
action_23 (69) = happyShift action_30
action_23 (70) = happyShift action_31
action_23 (71) = happyShift action_32
action_23 (6) = happyGoto action_10
action_23 (7) = happyGoto action_11
action_23 (8) = happyGoto action_12
action_23 (9) = happyGoto action_13
action_23 (10) = happyGoto action_14
action_23 (11) = happyGoto action_15
action_23 (12) = happyGoto action_35
action_23 (15) = happyGoto action_17
action_23 (16) = happyGoto action_18
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (61) = happyShift action_34
action_24 _ = happyReduce_17

action_25 (46) = happyShift action_21
action_25 (56) = happyShift action_23
action_25 (60) = happyShift action_24
action_25 (61) = happyShift action_25
action_25 (65) = happyShift action_26
action_25 (66) = happyShift action_27
action_25 (67) = happyShift action_28
action_25 (68) = happyShift action_29
action_25 (69) = happyShift action_30
action_25 (70) = happyShift action_31
action_25 (71) = happyShift action_32
action_25 (6) = happyGoto action_10
action_25 (7) = happyGoto action_11
action_25 (8) = happyGoto action_12
action_25 (9) = happyGoto action_13
action_25 (10) = happyGoto action_14
action_25 (11) = happyGoto action_15
action_25 (12) = happyGoto action_33
action_25 (15) = happyGoto action_17
action_25 (16) = happyGoto action_18
action_25 _ = happyFail (happyExpListPerState 25)

action_26 _ = happyReduce_18

action_27 _ = happyReduce_9

action_28 _ = happyReduce_10

action_29 _ = happyReduce_8

action_30 _ = happyReduce_6

action_31 _ = happyReduce_7

action_32 _ = happyReduce_5

action_33 (45) = happyShift action_39
action_33 (46) = happyShift action_40
action_33 (47) = happyShift action_41
action_33 (48) = happyShift action_42
action_33 (49) = happyShift action_43
action_33 (50) = happyShift action_44
action_33 (51) = happyShift action_45
action_33 (52) = happyShift action_46
action_33 (53) = happyShift action_47
action_33 (54) = happyShift action_48
action_33 (55) = happyShift action_49
action_33 (57) = happyShift action_50
action_33 (58) = happyShift action_51
action_33 (62) = happyShift action_75
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (46) = happyShift action_21
action_34 (56) = happyShift action_23
action_34 (60) = happyShift action_24
action_34 (61) = happyShift action_25
action_34 (65) = happyShift action_26
action_34 (66) = happyShift action_27
action_34 (67) = happyShift action_28
action_34 (68) = happyShift action_29
action_34 (69) = happyShift action_30
action_34 (70) = happyShift action_31
action_34 (71) = happyShift action_32
action_34 (6) = happyGoto action_10
action_34 (7) = happyGoto action_11
action_34 (8) = happyGoto action_12
action_34 (9) = happyGoto action_13
action_34 (10) = happyGoto action_14
action_34 (11) = happyGoto action_15
action_34 (12) = happyGoto action_72
action_34 (13) = happyGoto action_73
action_34 (14) = happyGoto action_74
action_34 (15) = happyGoto action_17
action_34 (16) = happyGoto action_18
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (45) = happyShift action_39
action_35 (46) = happyShift action_40
action_35 (47) = happyShift action_41
action_35 (48) = happyShift action_42
action_35 (49) = happyShift action_43
action_35 (50) = happyShift action_44
action_35 (51) = happyShift action_45
action_35 (52) = happyShift action_46
action_35 (53) = happyShift action_47
action_35 (54) = happyShift action_48
action_35 (55) = happyShift action_49
action_35 (57) = happyShift action_50
action_35 (58) = happyShift action_51
action_35 _ = happyReduce_39

action_36 (45) = happyShift action_39
action_36 (46) = happyShift action_40
action_36 (47) = happyShift action_41
action_36 (48) = happyShift action_42
action_36 (49) = happyShift action_43
action_36 (50) = happyShift action_44
action_36 (51) = happyShift action_45
action_36 (52) = happyShift action_46
action_36 (53) = happyShift action_47
action_36 (54) = happyShift action_48
action_36 (55) = happyShift action_49
action_36 (57) = happyShift action_50
action_36 (58) = happyShift action_51
action_36 _ = happyReduce_40

action_37 (46) = happyShift action_21
action_37 (56) = happyShift action_23
action_37 (60) = happyShift action_24
action_37 (61) = happyShift action_25
action_37 (65) = happyShift action_26
action_37 (66) = happyShift action_27
action_37 (67) = happyShift action_28
action_37 (68) = happyShift action_29
action_37 (69) = happyShift action_30
action_37 (70) = happyShift action_31
action_37 (71) = happyShift action_32
action_37 (6) = happyGoto action_10
action_37 (7) = happyGoto action_11
action_37 (8) = happyGoto action_12
action_37 (9) = happyGoto action_13
action_37 (10) = happyGoto action_14
action_37 (11) = happyGoto action_15
action_37 (12) = happyGoto action_16
action_37 (15) = happyGoto action_17
action_37 (16) = happyGoto action_18
action_37 (19) = happyGoto action_71
action_37 _ = happyFail (happyExpListPerState 37)

action_38 _ = happyReduce_46

action_39 (46) = happyShift action_21
action_39 (56) = happyShift action_23
action_39 (60) = happyShift action_24
action_39 (61) = happyShift action_25
action_39 (65) = happyShift action_26
action_39 (66) = happyShift action_27
action_39 (67) = happyShift action_28
action_39 (68) = happyShift action_29
action_39 (69) = happyShift action_30
action_39 (70) = happyShift action_31
action_39 (71) = happyShift action_32
action_39 (6) = happyGoto action_10
action_39 (7) = happyGoto action_11
action_39 (8) = happyGoto action_12
action_39 (9) = happyGoto action_13
action_39 (10) = happyGoto action_14
action_39 (11) = happyGoto action_15
action_39 (12) = happyGoto action_70
action_39 (15) = happyGoto action_17
action_39 (16) = happyGoto action_18
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (46) = happyShift action_21
action_40 (56) = happyShift action_23
action_40 (60) = happyShift action_24
action_40 (61) = happyShift action_25
action_40 (65) = happyShift action_26
action_40 (66) = happyShift action_27
action_40 (67) = happyShift action_28
action_40 (68) = happyShift action_29
action_40 (69) = happyShift action_30
action_40 (70) = happyShift action_31
action_40 (71) = happyShift action_32
action_40 (6) = happyGoto action_10
action_40 (7) = happyGoto action_11
action_40 (8) = happyGoto action_12
action_40 (9) = happyGoto action_13
action_40 (10) = happyGoto action_14
action_40 (11) = happyGoto action_15
action_40 (12) = happyGoto action_69
action_40 (15) = happyGoto action_17
action_40 (16) = happyGoto action_18
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (46) = happyShift action_21
action_41 (56) = happyShift action_23
action_41 (60) = happyShift action_24
action_41 (61) = happyShift action_25
action_41 (65) = happyShift action_26
action_41 (66) = happyShift action_27
action_41 (67) = happyShift action_28
action_41 (68) = happyShift action_29
action_41 (69) = happyShift action_30
action_41 (70) = happyShift action_31
action_41 (71) = happyShift action_32
action_41 (6) = happyGoto action_10
action_41 (7) = happyGoto action_11
action_41 (8) = happyGoto action_12
action_41 (9) = happyGoto action_13
action_41 (10) = happyGoto action_14
action_41 (11) = happyGoto action_15
action_41 (12) = happyGoto action_68
action_41 (15) = happyGoto action_17
action_41 (16) = happyGoto action_18
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (46) = happyShift action_21
action_42 (56) = happyShift action_23
action_42 (60) = happyShift action_24
action_42 (61) = happyShift action_25
action_42 (65) = happyShift action_26
action_42 (66) = happyShift action_27
action_42 (67) = happyShift action_28
action_42 (68) = happyShift action_29
action_42 (69) = happyShift action_30
action_42 (70) = happyShift action_31
action_42 (71) = happyShift action_32
action_42 (6) = happyGoto action_10
action_42 (7) = happyGoto action_11
action_42 (8) = happyGoto action_12
action_42 (9) = happyGoto action_13
action_42 (10) = happyGoto action_14
action_42 (11) = happyGoto action_15
action_42 (12) = happyGoto action_67
action_42 (15) = happyGoto action_17
action_42 (16) = happyGoto action_18
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (46) = happyShift action_21
action_43 (56) = happyShift action_23
action_43 (60) = happyShift action_24
action_43 (61) = happyShift action_25
action_43 (65) = happyShift action_26
action_43 (66) = happyShift action_27
action_43 (67) = happyShift action_28
action_43 (68) = happyShift action_29
action_43 (69) = happyShift action_30
action_43 (70) = happyShift action_31
action_43 (71) = happyShift action_32
action_43 (6) = happyGoto action_10
action_43 (7) = happyGoto action_11
action_43 (8) = happyGoto action_12
action_43 (9) = happyGoto action_13
action_43 (10) = happyGoto action_14
action_43 (11) = happyGoto action_15
action_43 (12) = happyGoto action_66
action_43 (15) = happyGoto action_17
action_43 (16) = happyGoto action_18
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (46) = happyShift action_21
action_44 (56) = happyShift action_23
action_44 (60) = happyShift action_24
action_44 (61) = happyShift action_25
action_44 (65) = happyShift action_26
action_44 (66) = happyShift action_27
action_44 (67) = happyShift action_28
action_44 (68) = happyShift action_29
action_44 (69) = happyShift action_30
action_44 (70) = happyShift action_31
action_44 (71) = happyShift action_32
action_44 (6) = happyGoto action_10
action_44 (7) = happyGoto action_11
action_44 (8) = happyGoto action_12
action_44 (9) = happyGoto action_13
action_44 (10) = happyGoto action_14
action_44 (11) = happyGoto action_15
action_44 (12) = happyGoto action_65
action_44 (15) = happyGoto action_17
action_44 (16) = happyGoto action_18
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (46) = happyShift action_21
action_45 (56) = happyShift action_23
action_45 (60) = happyShift action_24
action_45 (61) = happyShift action_25
action_45 (65) = happyShift action_26
action_45 (66) = happyShift action_27
action_45 (67) = happyShift action_28
action_45 (68) = happyShift action_29
action_45 (69) = happyShift action_30
action_45 (70) = happyShift action_31
action_45 (71) = happyShift action_32
action_45 (6) = happyGoto action_10
action_45 (7) = happyGoto action_11
action_45 (8) = happyGoto action_12
action_45 (9) = happyGoto action_13
action_45 (10) = happyGoto action_14
action_45 (11) = happyGoto action_15
action_45 (12) = happyGoto action_64
action_45 (15) = happyGoto action_17
action_45 (16) = happyGoto action_18
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (46) = happyShift action_21
action_46 (56) = happyShift action_23
action_46 (60) = happyShift action_24
action_46 (61) = happyShift action_25
action_46 (65) = happyShift action_26
action_46 (66) = happyShift action_27
action_46 (67) = happyShift action_28
action_46 (68) = happyShift action_29
action_46 (69) = happyShift action_30
action_46 (70) = happyShift action_31
action_46 (71) = happyShift action_32
action_46 (6) = happyGoto action_10
action_46 (7) = happyGoto action_11
action_46 (8) = happyGoto action_12
action_46 (9) = happyGoto action_13
action_46 (10) = happyGoto action_14
action_46 (11) = happyGoto action_15
action_46 (12) = happyGoto action_63
action_46 (15) = happyGoto action_17
action_46 (16) = happyGoto action_18
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (46) = happyShift action_21
action_47 (56) = happyShift action_23
action_47 (60) = happyShift action_24
action_47 (61) = happyShift action_25
action_47 (65) = happyShift action_26
action_47 (66) = happyShift action_27
action_47 (67) = happyShift action_28
action_47 (68) = happyShift action_29
action_47 (69) = happyShift action_30
action_47 (70) = happyShift action_31
action_47 (71) = happyShift action_32
action_47 (6) = happyGoto action_10
action_47 (7) = happyGoto action_11
action_47 (8) = happyGoto action_12
action_47 (9) = happyGoto action_13
action_47 (10) = happyGoto action_14
action_47 (11) = happyGoto action_15
action_47 (12) = happyGoto action_62
action_47 (15) = happyGoto action_17
action_47 (16) = happyGoto action_18
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (46) = happyShift action_21
action_48 (56) = happyShift action_23
action_48 (60) = happyShift action_24
action_48 (61) = happyShift action_25
action_48 (65) = happyShift action_26
action_48 (66) = happyShift action_27
action_48 (67) = happyShift action_28
action_48 (68) = happyShift action_29
action_48 (69) = happyShift action_30
action_48 (70) = happyShift action_31
action_48 (71) = happyShift action_32
action_48 (6) = happyGoto action_10
action_48 (7) = happyGoto action_11
action_48 (8) = happyGoto action_12
action_48 (9) = happyGoto action_13
action_48 (10) = happyGoto action_14
action_48 (11) = happyGoto action_15
action_48 (12) = happyGoto action_61
action_48 (15) = happyGoto action_17
action_48 (16) = happyGoto action_18
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (46) = happyShift action_21
action_49 (56) = happyShift action_23
action_49 (60) = happyShift action_24
action_49 (61) = happyShift action_25
action_49 (65) = happyShift action_26
action_49 (66) = happyShift action_27
action_49 (67) = happyShift action_28
action_49 (68) = happyShift action_29
action_49 (69) = happyShift action_30
action_49 (70) = happyShift action_31
action_49 (71) = happyShift action_32
action_49 (6) = happyGoto action_10
action_49 (7) = happyGoto action_11
action_49 (8) = happyGoto action_12
action_49 (9) = happyGoto action_13
action_49 (10) = happyGoto action_14
action_49 (11) = happyGoto action_15
action_49 (12) = happyGoto action_60
action_49 (15) = happyGoto action_17
action_49 (16) = happyGoto action_18
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (46) = happyShift action_21
action_50 (56) = happyShift action_23
action_50 (60) = happyShift action_24
action_50 (61) = happyShift action_25
action_50 (65) = happyShift action_26
action_50 (66) = happyShift action_27
action_50 (67) = happyShift action_28
action_50 (68) = happyShift action_29
action_50 (69) = happyShift action_30
action_50 (70) = happyShift action_31
action_50 (71) = happyShift action_32
action_50 (6) = happyGoto action_10
action_50 (7) = happyGoto action_11
action_50 (8) = happyGoto action_12
action_50 (9) = happyGoto action_13
action_50 (10) = happyGoto action_14
action_50 (11) = happyGoto action_15
action_50 (12) = happyGoto action_59
action_50 (15) = happyGoto action_17
action_50 (16) = happyGoto action_18
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (46) = happyShift action_21
action_51 (56) = happyShift action_23
action_51 (60) = happyShift action_24
action_51 (61) = happyShift action_25
action_51 (65) = happyShift action_26
action_51 (66) = happyShift action_27
action_51 (67) = happyShift action_28
action_51 (68) = happyShift action_29
action_51 (69) = happyShift action_30
action_51 (70) = happyShift action_31
action_51 (71) = happyShift action_32
action_51 (6) = happyGoto action_10
action_51 (7) = happyGoto action_11
action_51 (8) = happyGoto action_12
action_51 (9) = happyGoto action_13
action_51 (10) = happyGoto action_14
action_51 (11) = happyGoto action_15
action_51 (12) = happyGoto action_58
action_51 (15) = happyGoto action_17
action_51 (16) = happyGoto action_18
action_51 _ = happyFail (happyExpListPerState 51)

action_52 (60) = happyShift action_57
action_52 _ = happyFail (happyExpListPerState 52)

action_53 _ = happyReduce_3

action_54 _ = happyReduce_53

action_55 (60) = happyShift action_9
action_55 (23) = happyGoto action_56
action_55 _ = happyFail (happyExpListPerState 55)

action_56 _ = happyReduce_51

action_57 _ = happyReduce_4

action_58 (45) = happyShift action_39
action_58 (46) = happyShift action_40
action_58 (47) = happyShift action_41
action_58 (48) = happyShift action_42
action_58 (49) = happyShift action_43
action_58 (50) = happyShift action_44
action_58 (51) = happyShift action_45
action_58 (52) = happyShift action_46
action_58 (53) = happyShift action_47
action_58 (54) = happyShift action_48
action_58 (55) = happyShift action_49
action_58 (57) = happyShift action_50
action_58 (58) = happyShift action_51
action_58 _ = happyReduce_38

action_59 (45) = happyShift action_39
action_59 (46) = happyShift action_40
action_59 (47) = happyShift action_41
action_59 (48) = happyShift action_42
action_59 (49) = happyShift action_43
action_59 (50) = happyShift action_44
action_59 (51) = happyShift action_45
action_59 (52) = happyShift action_46
action_59 (53) = happyShift action_47
action_59 (54) = happyShift action_48
action_59 (55) = happyShift action_49
action_59 (57) = happyShift action_50
action_59 (58) = happyShift action_51
action_59 _ = happyReduce_37

action_60 (45) = happyShift action_39
action_60 (46) = happyShift action_40
action_60 (47) = happyShift action_41
action_60 (48) = happyShift action_42
action_60 (49) = happyShift action_43
action_60 (50) = happyShift action_44
action_60 (51) = happyShift action_45
action_60 (52) = happyShift action_46
action_60 (53) = happyShift action_47
action_60 (54) = happyShift action_48
action_60 (55) = happyShift action_49
action_60 (57) = happyShift action_50
action_60 (58) = happyShift action_51
action_60 _ = happyReduce_36

action_61 (45) = happyShift action_39
action_61 (46) = happyShift action_40
action_61 (47) = happyShift action_41
action_61 (48) = happyShift action_42
action_61 (49) = happyShift action_43
action_61 (50) = happyShift action_44
action_61 (51) = happyShift action_45
action_61 (52) = happyShift action_46
action_61 (53) = happyShift action_47
action_61 (54) = happyShift action_48
action_61 (55) = happyShift action_49
action_61 (57) = happyShift action_50
action_61 (58) = happyShift action_51
action_61 _ = happyReduce_35

action_62 (45) = happyShift action_39
action_62 (46) = happyShift action_40
action_62 (47) = happyShift action_41
action_62 (48) = happyShift action_42
action_62 (49) = happyShift action_43
action_62 (50) = happyShift action_44
action_62 (51) = happyShift action_45
action_62 (52) = happyShift action_46
action_62 (53) = happyShift action_47
action_62 (54) = happyShift action_48
action_62 (55) = happyShift action_49
action_62 (57) = happyShift action_50
action_62 (58) = happyShift action_51
action_62 _ = happyReduce_34

action_63 (45) = happyShift action_39
action_63 (46) = happyShift action_40
action_63 (47) = happyShift action_41
action_63 (48) = happyShift action_42
action_63 (49) = happyShift action_43
action_63 (50) = happyShift action_44
action_63 (51) = happyShift action_45
action_63 (52) = happyShift action_46
action_63 (53) = happyShift action_47
action_63 (54) = happyShift action_48
action_63 (55) = happyShift action_49
action_63 (57) = happyShift action_50
action_63 (58) = happyShift action_51
action_63 _ = happyReduce_33

action_64 (45) = happyShift action_39
action_64 (46) = happyShift action_40
action_64 (47) = happyShift action_41
action_64 (48) = happyShift action_42
action_64 (49) = happyShift action_43
action_64 (50) = happyShift action_44
action_64 (51) = happyShift action_45
action_64 (52) = happyShift action_46
action_64 (53) = happyShift action_47
action_64 (54) = happyShift action_48
action_64 (55) = happyShift action_49
action_64 (57) = happyShift action_50
action_64 (58) = happyShift action_51
action_64 _ = happyReduce_32

action_65 (45) = happyShift action_39
action_65 (46) = happyShift action_40
action_65 (47) = happyShift action_41
action_65 (48) = happyShift action_42
action_65 (49) = happyShift action_43
action_65 (50) = happyShift action_44
action_65 (51) = happyShift action_45
action_65 (52) = happyShift action_46
action_65 (53) = happyShift action_47
action_65 (54) = happyShift action_48
action_65 (55) = happyShift action_49
action_65 (57) = happyShift action_50
action_65 (58) = happyShift action_51
action_65 _ = happyReduce_31

action_66 (45) = happyShift action_39
action_66 (46) = happyShift action_40
action_66 (47) = happyShift action_41
action_66 (48) = happyShift action_42
action_66 (49) = happyShift action_43
action_66 (50) = happyShift action_44
action_66 (51) = happyShift action_45
action_66 (52) = happyShift action_46
action_66 (53) = happyShift action_47
action_66 (54) = happyShift action_48
action_66 (55) = happyShift action_49
action_66 (57) = happyShift action_50
action_66 (58) = happyShift action_51
action_66 _ = happyReduce_30

action_67 (45) = happyShift action_39
action_67 (46) = happyShift action_40
action_67 (47) = happyShift action_41
action_67 (48) = happyShift action_42
action_67 (49) = happyShift action_43
action_67 (50) = happyShift action_44
action_67 (51) = happyShift action_45
action_67 (52) = happyShift action_46
action_67 (53) = happyShift action_47
action_67 (54) = happyShift action_48
action_67 (55) = happyShift action_49
action_67 (57) = happyShift action_50
action_67 (58) = happyShift action_51
action_67 _ = happyReduce_29

action_68 (45) = happyShift action_39
action_68 (46) = happyShift action_40
action_68 (47) = happyShift action_41
action_68 (48) = happyShift action_42
action_68 (49) = happyShift action_43
action_68 (50) = happyShift action_44
action_68 (51) = happyShift action_45
action_68 (52) = happyShift action_46
action_68 (53) = happyShift action_47
action_68 (54) = happyShift action_48
action_68 (55) = happyShift action_49
action_68 (57) = happyShift action_50
action_68 (58) = happyShift action_51
action_68 _ = happyReduce_28

action_69 (45) = happyShift action_39
action_69 (46) = happyShift action_40
action_69 (47) = happyShift action_41
action_69 (48) = happyShift action_42
action_69 (49) = happyShift action_43
action_69 (50) = happyShift action_44
action_69 (51) = happyShift action_45
action_69 (52) = happyShift action_46
action_69 (53) = happyShift action_47
action_69 (54) = happyShift action_48
action_69 (55) = happyShift action_49
action_69 (57) = happyShift action_50
action_69 (58) = happyShift action_51
action_69 _ = happyReduce_27

action_70 (45) = happyShift action_39
action_70 (46) = happyShift action_40
action_70 (47) = happyShift action_41
action_70 (48) = happyShift action_42
action_70 (49) = happyShift action_43
action_70 (50) = happyShift action_44
action_70 (51) = happyShift action_45
action_70 (52) = happyShift action_46
action_70 (53) = happyShift action_47
action_70 (54) = happyShift action_48
action_70 (55) = happyShift action_49
action_70 (57) = happyShift action_50
action_70 (58) = happyShift action_51
action_70 _ = happyReduce_26

action_71 _ = happyReduce_44

action_72 (45) = happyShift action_39
action_72 (46) = happyShift action_40
action_72 (47) = happyShift action_41
action_72 (48) = happyShift action_42
action_72 (49) = happyShift action_43
action_72 (50) = happyShift action_44
action_72 (51) = happyShift action_45
action_72 (52) = happyShift action_46
action_72 (53) = happyShift action_47
action_72 (54) = happyShift action_48
action_72 (55) = happyShift action_49
action_72 (57) = happyShift action_50
action_72 (58) = happyShift action_51
action_72 _ = happyReduce_25

action_73 (62) = happyShift action_76
action_73 (63) = happyShift action_77
action_73 _ = happyFail (happyExpListPerState 73)

action_74 _ = happyReduce_23

action_75 _ = happyReduce_22

action_76 _ = happyReduce_19

action_77 (46) = happyShift action_21
action_77 (56) = happyShift action_23
action_77 (60) = happyShift action_24
action_77 (61) = happyShift action_25
action_77 (65) = happyShift action_26
action_77 (66) = happyShift action_27
action_77 (67) = happyShift action_28
action_77 (68) = happyShift action_29
action_77 (69) = happyShift action_30
action_77 (70) = happyShift action_31
action_77 (71) = happyShift action_32
action_77 (6) = happyGoto action_10
action_77 (7) = happyGoto action_11
action_77 (8) = happyGoto action_12
action_77 (9) = happyGoto action_13
action_77 (10) = happyGoto action_14
action_77 (11) = happyGoto action_15
action_77 (12) = happyGoto action_72
action_77 (14) = happyGoto action_78
action_77 (15) = happyGoto action_17
action_77 (16) = happyGoto action_18
action_77 _ = happyFail (happyExpListPerState 77)

action_78 _ = happyReduce_24

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn4
		 (S.Select happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn21  happy_var_1)
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

happyReduce_16 = happySpecReduce_1  12 happyReduction_16
happyReduction_16 (HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Constant happy_var_1
	)
happyReduction_16 _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  12 happyReduction_17
happyReduction_17 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn12
		 (S.Identifier happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  12 happyReduction_18
happyReduction_18 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn12
		 (S.Identifier happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happyReduce 4 12 happyReduction_19
happyReduction_19 (_ `HappyStk`
	(HappyAbsSyn13  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (T.Identifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn12
		 (S.Function happy_var_1 happy_var_3
	) `HappyStk` happyRest

happyReduce_20 = happySpecReduce_1  12 happyReduction_20
happyReduction_20 (HappyAbsSyn15  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Operator (S.Binary happy_var_1)
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_1  12 happyReduction_21
happyReduction_21 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn12
		 (S.Operator (S.Unary happy_var_1)
	)
happyReduction_21 _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  12 happyReduction_22
happyReduction_22 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_1  13 happyReduction_23
happyReduction_23 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([ happy_var_1 ]
	)
happyReduction_23 _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  13 happyReduction_24
happyReduction_24 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 ((happy_var_3 : happy_var_1)
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_1  14 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_25 _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  15 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  15 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  15 happyReduction_28
happyReduction_28 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  15 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  15 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  15 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  15 happyReduction_33
happyReduction_33 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  15 happyReduction_34
happyReduction_34 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  15 happyReduction_35
happyReduction_35 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  15 happyReduction_36
happyReduction_36 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_3  15 happyReduction_38
happyReduction_38 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_38 _ _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  16 happyReduction_39
happyReduction_39 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (S.Not happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  16 happyReduction_40
happyReduction_40 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (S.Neg happy_var_2
	)
happyReduction_40 _ _  = notHappyAtAll 

happyReduce_41 = happySpecReduce_2  17 happyReduction_41
happyReduction_41 _
	_
	 =  HappyAbsSyn17
		 (S.Wildcard
	)

happyReduce_42 = happySpecReduce_2  17 happyReduction_42
happyReduction_42 (HappyAbsSyn18  happy_var_2)
	_
	 =  HappyAbsSyn17
		 (S.Columns happy_var_2
	)
happyReduction_42 _ _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_1  18 happyReduction_43
happyReduction_43 (HappyAbsSyn19  happy_var_1)
	 =  HappyAbsSyn18
		 ([happy_var_1]
	)
happyReduction_43 _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_3  18 happyReduction_44
happyReduction_44 (HappyAbsSyn19  happy_var_3)
	_
	(HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn18
		 (happy_var_3 : happy_var_1
	)
happyReduction_44 _ _ _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_1  19 happyReduction_45
happyReduction_45 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn19
		 (S.Column happy_var_1 Nothing
	)
happyReduction_45 _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  19 happyReduction_46
happyReduction_46 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn19
		 (S.Column happy_var_1 happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  20 happyReduction_47
happyReduction_47 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_1  20 happyReduction_48
happyReduction_48 (HappyTerminal (T.Dotwalk happy_var_1))
	 =  HappyAbsSyn20
		 (happy_var_1
	)
happyReduction_48 _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_2  21 happyReduction_49
happyReduction_49 (HappyAbsSyn22  happy_var_2)
	_
	 =  HappyAbsSyn21
		 (happy_var_2
	)
happyReduction_49 _ _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_1  22 happyReduction_50
happyReduction_50 (HappyAbsSyn23  happy_var_1)
	 =  HappyAbsSyn22
		 ([ happy_var_1 ]
	)
happyReduction_50 _  = notHappyAtAll 

happyReduce_51 = happySpecReduce_3  22 happyReduction_51
happyReduction_51 (HappyAbsSyn23  happy_var_3)
	_
	(HappyAbsSyn22  happy_var_1)
	 =  HappyAbsSyn22
		 (happy_var_3 : happy_var_1
	)
happyReduction_51 _ _ _  = notHappyAtAll 

happyReduce_52 = happySpecReduce_1  23 happyReduction_52
happyReduction_52 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn23
		 (S.Table happy_var_1 Nothing
	)
happyReduction_52 _  = notHappyAtAll 

happyReduce_53 = happySpecReduce_2  23 happyReduction_53
happyReduction_53 (HappyAbsSyn5  happy_var_2)
	(HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn23
		 (S.Table happy_var_1 happy_var_2
	)
happyReduction_53 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 72 72 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.Select -> cont 24;
	T.From -> cont 25;
	T.Where -> cont 26;
	T.GroupBy -> cont 27;
	T.Having -> cont 28;
	T.In -> cont 29;
	T.Distinct -> cont 30;
	T.Limit -> cont 31;
	T.OrderBy -> cont 32;
	T.Ascending -> cont 33;
	T.Descending -> cont 34;
	T.Union -> cont 35;
	T.Intersect -> cont 36;
	T.All -> cont 37;
	T.Left -> cont 38;
	T.Right -> cont 39;
	T.Inner -> cont 40;
	T.Outer -> cont 41;
	T.Natural -> cont 42;
	T.Join -> cont 43;
	T.On -> cont 44;
	T.Plus -> cont 45;
	T.Minus -> cont 46;
	T.Asterisk -> cont 47;
	T.FloatDivide -> cont 48;
	T.Modulo -> cont 49;
	T.Equals -> cont 50;
	T.NotEquals -> cont 51;
	T.LT -> cont 52;
	T.LTE -> cont 53;
	T.GT -> cont 54;
	T.GTE -> cont 55;
	T.Not -> cont 56;
	T.And -> cont 57;
	T.Or -> cont 58;
	T.As -> cont 59;
	T.Identifier happy_dollar_dollar -> cont 60;
	T.LeftParen -> cont 61;
	T.RightParen -> cont 62;
	T.Comma -> cont 63;
	T.BlockComment happy_dollar_dollar -> cont 64;
	T.Dotwalk happy_dollar_dollar -> cont 65;
	T.Constant (T.Integer happy_dollar_dollar) -> cont 66;
	T.Constant (T.Float happy_dollar_dollar) -> cont 67;
	T.Constant (T.String happy_dollar_dollar) -> cont 68;
	T.Constant (T.Boolean T.TrueVal) -> cont 69;
	T.Constant (T.Boolean T.FalseVal) -> cont 70;
	T.Constant (T.Boolean T.Null ) -> cont 71;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 72 tk tks = happyError' (tks, explist)
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
