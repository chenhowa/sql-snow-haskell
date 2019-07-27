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
	| HappyAbsSyn19 ([S.Table])
	| HappyAbsSyn20 ([ S.Table ])
	| HappyAbsSyn21 (S.Table)

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
 action_77 :: () => Int -> ({-HappyReduction (HappyIdentity) = -}
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
 happyReduce_50 :: () => ({-HappyReduction (HappyIdentity) = -}
	   Int 
	-> (Tok)
	-> HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)
	-> [HappyState (Tok) (HappyStk HappyAbsSyn -> [(Tok)] -> (HappyIdentity) HappyAbsSyn)] 
	-> HappyStk HappyAbsSyn 
	-> [(Tok)] -> (HappyIdentity) HappyAbsSyn)

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,324) ([0,96,0,0,0,2048,0,0,0,0,0,0,0,0,0,24576,6272,127,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,64,0,0,0,0,0,0,0,49152,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64512,991,0,0,0,0,0,0,0,0,256,0,0,0,0,0,0,0,8200,8134,0,0,0,0,0,0,32768,25088,508,0,0,0,16,0,0,2048,50720,31,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,64512,2271,0,0,0,34818,2033,0,0,0,0,0,0,0,0,0,0,0,8200,8134,0,0,0,0,0,0,32768,25088,508,0,0,32800,32536,0,0,2048,50720,31,0,0,34818,2033,0,0,128,64610,1,0,8192,6272,127,0,0,8200,8134,0,0,512,61832,7,0,32768,25088,508,0,0,32800,32536,0,0,2048,50720,31,0,0,34818,2033,0,0,128,64610,1,0,0,2048,0,0,0,0,0,0,0,0,0,0,0,0,8192,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,32752,3,0,0,0,6144,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8200,8134,0,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","Alias","Null","True","False","String","Number","Primitive","Expr","Args","Arg","Operator","Select","Columns","Column","From","Tables","Table","select","from","where","groupBy","having","in","distinct","limit","orderBy","asc","desc","union","intersect","all","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","'('","')'","','","bc","dotwalk","integer","float","string","true","false","null","%eof"]
        bit_start = st * 70
        bit_end = (st + 1) * 70
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..69]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (22) = happyShift action_3
action_0 (23) = happyShift action_6
action_0 (4) = happyGoto action_4
action_0 (16) = happyGoto action_2
action_0 (19) = happyGoto action_5
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (22) = happyShift action_3
action_1 (16) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (44) = happyShift action_20
action_3 (45) = happyShift action_21
action_3 (54) = happyShift action_22
action_3 (58) = happyShift action_23
action_3 (59) = happyShift action_24
action_3 (63) = happyShift action_25
action_3 (64) = happyShift action_26
action_3 (65) = happyShift action_27
action_3 (66) = happyShift action_28
action_3 (67) = happyShift action_29
action_3 (68) = happyShift action_30
action_3 (69) = happyShift action_31
action_3 (6) = happyGoto action_10
action_3 (7) = happyGoto action_11
action_3 (8) = happyGoto action_12
action_3 (9) = happyGoto action_13
action_3 (10) = happyGoto action_14
action_3 (11) = happyGoto action_15
action_3 (12) = happyGoto action_16
action_3 (15) = happyGoto action_17
action_3 (17) = happyGoto action_18
action_3 (18) = happyGoto action_19
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (70) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 _ = happyReduce_2

action_6 (58) = happyShift action_9
action_6 (20) = happyGoto action_7
action_6 (21) = happyGoto action_8
action_6 _ = happyFail (happyExpListPerState 6)

action_7 (61) = happyShift action_54
action_7 _ = happyReduce_46

action_8 _ = happyReduce_47

action_9 (57) = happyShift action_51
action_9 (58) = happyShift action_52
action_9 (5) = happyGoto action_53
action_9 _ = happyReduce_49

action_10 _ = happyReduce_11

action_11 _ = happyReduce_12

action_12 _ = happyReduce_13

action_13 _ = happyReduce_14

action_14 _ = happyReduce_15

action_15 _ = happyReduce_16

action_16 (43) = happyShift action_38
action_16 (44) = happyShift action_39
action_16 (45) = happyShift action_40
action_16 (46) = happyShift action_41
action_16 (47) = happyShift action_42
action_16 (48) = happyShift action_43
action_16 (49) = happyShift action_44
action_16 (50) = happyShift action_45
action_16 (51) = happyShift action_46
action_16 (52) = happyShift action_47
action_16 (53) = happyShift action_48
action_16 (55) = happyShift action_49
action_16 (56) = happyShift action_50
action_16 (57) = happyShift action_51
action_16 (58) = happyShift action_52
action_16 (5) = happyGoto action_37
action_16 _ = happyReduce_44

action_17 _ = happyReduce_20

action_18 (61) = happyShift action_36
action_18 _ = happyReduce_41

action_19 _ = happyReduce_42

action_20 (44) = happyShift action_20
action_20 (54) = happyShift action_22
action_20 (58) = happyShift action_23
action_20 (59) = happyShift action_24
action_20 (63) = happyShift action_25
action_20 (64) = happyShift action_26
action_20 (65) = happyShift action_27
action_20 (66) = happyShift action_28
action_20 (67) = happyShift action_29
action_20 (68) = happyShift action_30
action_20 (69) = happyShift action_31
action_20 (6) = happyGoto action_10
action_20 (7) = happyGoto action_11
action_20 (8) = happyGoto action_12
action_20 (9) = happyGoto action_13
action_20 (10) = happyGoto action_14
action_20 (11) = happyGoto action_15
action_20 (12) = happyGoto action_35
action_20 (15) = happyGoto action_17
action_20 _ = happyFail (happyExpListPerState 20)

action_21 _ = happyReduce_40

action_22 (44) = happyShift action_20
action_22 (54) = happyShift action_22
action_22 (58) = happyShift action_23
action_22 (59) = happyShift action_24
action_22 (63) = happyShift action_25
action_22 (64) = happyShift action_26
action_22 (65) = happyShift action_27
action_22 (66) = happyShift action_28
action_22 (67) = happyShift action_29
action_22 (68) = happyShift action_30
action_22 (69) = happyShift action_31
action_22 (6) = happyGoto action_10
action_22 (7) = happyGoto action_11
action_22 (8) = happyGoto action_12
action_22 (9) = happyGoto action_13
action_22 (10) = happyGoto action_14
action_22 (11) = happyGoto action_15
action_22 (12) = happyGoto action_34
action_22 (15) = happyGoto action_17
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (59) = happyShift action_33
action_23 _ = happyReduce_17

action_24 (44) = happyShift action_20
action_24 (54) = happyShift action_22
action_24 (58) = happyShift action_23
action_24 (59) = happyShift action_24
action_24 (63) = happyShift action_25
action_24 (64) = happyShift action_26
action_24 (65) = happyShift action_27
action_24 (66) = happyShift action_28
action_24 (67) = happyShift action_29
action_24 (68) = happyShift action_30
action_24 (69) = happyShift action_31
action_24 (6) = happyGoto action_10
action_24 (7) = happyGoto action_11
action_24 (8) = happyGoto action_12
action_24 (9) = happyGoto action_13
action_24 (10) = happyGoto action_14
action_24 (11) = happyGoto action_15
action_24 (12) = happyGoto action_32
action_24 (15) = happyGoto action_17
action_24 _ = happyFail (happyExpListPerState 24)

action_25 _ = happyReduce_18

action_26 _ = happyReduce_9

action_27 _ = happyReduce_10

action_28 _ = happyReduce_8

action_29 _ = happyReduce_6

action_30 _ = happyReduce_7

action_31 _ = happyReduce_5

action_32 (43) = happyShift action_38
action_32 (44) = happyShift action_39
action_32 (45) = happyShift action_40
action_32 (46) = happyShift action_41
action_32 (47) = happyShift action_42
action_32 (48) = happyShift action_43
action_32 (49) = happyShift action_44
action_32 (50) = happyShift action_45
action_32 (51) = happyShift action_46
action_32 (52) = happyShift action_47
action_32 (53) = happyShift action_48
action_32 (55) = happyShift action_49
action_32 (56) = happyShift action_50
action_32 (60) = happyShift action_74
action_32 _ = happyFail (happyExpListPerState 32)

action_33 (44) = happyShift action_20
action_33 (54) = happyShift action_22
action_33 (58) = happyShift action_23
action_33 (59) = happyShift action_24
action_33 (63) = happyShift action_25
action_33 (64) = happyShift action_26
action_33 (65) = happyShift action_27
action_33 (66) = happyShift action_28
action_33 (67) = happyShift action_29
action_33 (68) = happyShift action_30
action_33 (69) = happyShift action_31
action_33 (6) = happyGoto action_10
action_33 (7) = happyGoto action_11
action_33 (8) = happyGoto action_12
action_33 (9) = happyGoto action_13
action_33 (10) = happyGoto action_14
action_33 (11) = happyGoto action_15
action_33 (12) = happyGoto action_71
action_33 (13) = happyGoto action_72
action_33 (14) = happyGoto action_73
action_33 (15) = happyGoto action_17
action_33 _ = happyFail (happyExpListPerState 33)

action_34 (43) = happyShift action_38
action_34 (44) = happyShift action_39
action_34 (45) = happyShift action_40
action_34 (46) = happyShift action_41
action_34 (47) = happyShift action_42
action_34 (48) = happyShift action_43
action_34 (49) = happyShift action_44
action_34 (50) = happyShift action_45
action_34 (51) = happyShift action_46
action_34 (52) = happyShift action_47
action_34 (53) = happyShift action_48
action_34 (55) = happyShift action_49
action_34 (56) = happyShift action_50
action_34 _ = happyReduce_38

action_35 (43) = happyShift action_38
action_35 (44) = happyShift action_39
action_35 (45) = happyShift action_40
action_35 (46) = happyShift action_41
action_35 (47) = happyShift action_42
action_35 (48) = happyShift action_43
action_35 (49) = happyShift action_44
action_35 (50) = happyShift action_45
action_35 (51) = happyShift action_46
action_35 (52) = happyShift action_47
action_35 (53) = happyShift action_48
action_35 (55) = happyShift action_49
action_35 (56) = happyShift action_50
action_35 _ = happyReduce_39

action_36 (44) = happyShift action_20
action_36 (54) = happyShift action_22
action_36 (58) = happyShift action_23
action_36 (59) = happyShift action_24
action_36 (63) = happyShift action_25
action_36 (64) = happyShift action_26
action_36 (65) = happyShift action_27
action_36 (66) = happyShift action_28
action_36 (67) = happyShift action_29
action_36 (68) = happyShift action_30
action_36 (69) = happyShift action_31
action_36 (6) = happyGoto action_10
action_36 (7) = happyGoto action_11
action_36 (8) = happyGoto action_12
action_36 (9) = happyGoto action_13
action_36 (10) = happyGoto action_14
action_36 (11) = happyGoto action_15
action_36 (12) = happyGoto action_16
action_36 (15) = happyGoto action_17
action_36 (18) = happyGoto action_70
action_36 _ = happyFail (happyExpListPerState 36)

action_37 _ = happyReduce_45

action_38 (44) = happyShift action_20
action_38 (54) = happyShift action_22
action_38 (58) = happyShift action_23
action_38 (59) = happyShift action_24
action_38 (63) = happyShift action_25
action_38 (64) = happyShift action_26
action_38 (65) = happyShift action_27
action_38 (66) = happyShift action_28
action_38 (67) = happyShift action_29
action_38 (68) = happyShift action_30
action_38 (69) = happyShift action_31
action_38 (6) = happyGoto action_10
action_38 (7) = happyGoto action_11
action_38 (8) = happyGoto action_12
action_38 (9) = happyGoto action_13
action_38 (10) = happyGoto action_14
action_38 (11) = happyGoto action_15
action_38 (12) = happyGoto action_69
action_38 (15) = happyGoto action_17
action_38 _ = happyFail (happyExpListPerState 38)

action_39 (44) = happyShift action_20
action_39 (54) = happyShift action_22
action_39 (58) = happyShift action_23
action_39 (59) = happyShift action_24
action_39 (63) = happyShift action_25
action_39 (64) = happyShift action_26
action_39 (65) = happyShift action_27
action_39 (66) = happyShift action_28
action_39 (67) = happyShift action_29
action_39 (68) = happyShift action_30
action_39 (69) = happyShift action_31
action_39 (6) = happyGoto action_10
action_39 (7) = happyGoto action_11
action_39 (8) = happyGoto action_12
action_39 (9) = happyGoto action_13
action_39 (10) = happyGoto action_14
action_39 (11) = happyGoto action_15
action_39 (12) = happyGoto action_68
action_39 (15) = happyGoto action_17
action_39 _ = happyFail (happyExpListPerState 39)

action_40 (44) = happyShift action_20
action_40 (54) = happyShift action_22
action_40 (58) = happyShift action_23
action_40 (59) = happyShift action_24
action_40 (63) = happyShift action_25
action_40 (64) = happyShift action_26
action_40 (65) = happyShift action_27
action_40 (66) = happyShift action_28
action_40 (67) = happyShift action_29
action_40 (68) = happyShift action_30
action_40 (69) = happyShift action_31
action_40 (6) = happyGoto action_10
action_40 (7) = happyGoto action_11
action_40 (8) = happyGoto action_12
action_40 (9) = happyGoto action_13
action_40 (10) = happyGoto action_14
action_40 (11) = happyGoto action_15
action_40 (12) = happyGoto action_67
action_40 (15) = happyGoto action_17
action_40 _ = happyFail (happyExpListPerState 40)

action_41 (44) = happyShift action_20
action_41 (54) = happyShift action_22
action_41 (58) = happyShift action_23
action_41 (59) = happyShift action_24
action_41 (63) = happyShift action_25
action_41 (64) = happyShift action_26
action_41 (65) = happyShift action_27
action_41 (66) = happyShift action_28
action_41 (67) = happyShift action_29
action_41 (68) = happyShift action_30
action_41 (69) = happyShift action_31
action_41 (6) = happyGoto action_10
action_41 (7) = happyGoto action_11
action_41 (8) = happyGoto action_12
action_41 (9) = happyGoto action_13
action_41 (10) = happyGoto action_14
action_41 (11) = happyGoto action_15
action_41 (12) = happyGoto action_66
action_41 (15) = happyGoto action_17
action_41 _ = happyFail (happyExpListPerState 41)

action_42 (44) = happyShift action_20
action_42 (54) = happyShift action_22
action_42 (58) = happyShift action_23
action_42 (59) = happyShift action_24
action_42 (63) = happyShift action_25
action_42 (64) = happyShift action_26
action_42 (65) = happyShift action_27
action_42 (66) = happyShift action_28
action_42 (67) = happyShift action_29
action_42 (68) = happyShift action_30
action_42 (69) = happyShift action_31
action_42 (6) = happyGoto action_10
action_42 (7) = happyGoto action_11
action_42 (8) = happyGoto action_12
action_42 (9) = happyGoto action_13
action_42 (10) = happyGoto action_14
action_42 (11) = happyGoto action_15
action_42 (12) = happyGoto action_65
action_42 (15) = happyGoto action_17
action_42 _ = happyFail (happyExpListPerState 42)

action_43 (44) = happyShift action_20
action_43 (54) = happyShift action_22
action_43 (58) = happyShift action_23
action_43 (59) = happyShift action_24
action_43 (63) = happyShift action_25
action_43 (64) = happyShift action_26
action_43 (65) = happyShift action_27
action_43 (66) = happyShift action_28
action_43 (67) = happyShift action_29
action_43 (68) = happyShift action_30
action_43 (69) = happyShift action_31
action_43 (6) = happyGoto action_10
action_43 (7) = happyGoto action_11
action_43 (8) = happyGoto action_12
action_43 (9) = happyGoto action_13
action_43 (10) = happyGoto action_14
action_43 (11) = happyGoto action_15
action_43 (12) = happyGoto action_64
action_43 (15) = happyGoto action_17
action_43 _ = happyFail (happyExpListPerState 43)

action_44 (44) = happyShift action_20
action_44 (54) = happyShift action_22
action_44 (58) = happyShift action_23
action_44 (59) = happyShift action_24
action_44 (63) = happyShift action_25
action_44 (64) = happyShift action_26
action_44 (65) = happyShift action_27
action_44 (66) = happyShift action_28
action_44 (67) = happyShift action_29
action_44 (68) = happyShift action_30
action_44 (69) = happyShift action_31
action_44 (6) = happyGoto action_10
action_44 (7) = happyGoto action_11
action_44 (8) = happyGoto action_12
action_44 (9) = happyGoto action_13
action_44 (10) = happyGoto action_14
action_44 (11) = happyGoto action_15
action_44 (12) = happyGoto action_63
action_44 (15) = happyGoto action_17
action_44 _ = happyFail (happyExpListPerState 44)

action_45 (44) = happyShift action_20
action_45 (54) = happyShift action_22
action_45 (58) = happyShift action_23
action_45 (59) = happyShift action_24
action_45 (63) = happyShift action_25
action_45 (64) = happyShift action_26
action_45 (65) = happyShift action_27
action_45 (66) = happyShift action_28
action_45 (67) = happyShift action_29
action_45 (68) = happyShift action_30
action_45 (69) = happyShift action_31
action_45 (6) = happyGoto action_10
action_45 (7) = happyGoto action_11
action_45 (8) = happyGoto action_12
action_45 (9) = happyGoto action_13
action_45 (10) = happyGoto action_14
action_45 (11) = happyGoto action_15
action_45 (12) = happyGoto action_62
action_45 (15) = happyGoto action_17
action_45 _ = happyFail (happyExpListPerState 45)

action_46 (44) = happyShift action_20
action_46 (54) = happyShift action_22
action_46 (58) = happyShift action_23
action_46 (59) = happyShift action_24
action_46 (63) = happyShift action_25
action_46 (64) = happyShift action_26
action_46 (65) = happyShift action_27
action_46 (66) = happyShift action_28
action_46 (67) = happyShift action_29
action_46 (68) = happyShift action_30
action_46 (69) = happyShift action_31
action_46 (6) = happyGoto action_10
action_46 (7) = happyGoto action_11
action_46 (8) = happyGoto action_12
action_46 (9) = happyGoto action_13
action_46 (10) = happyGoto action_14
action_46 (11) = happyGoto action_15
action_46 (12) = happyGoto action_61
action_46 (15) = happyGoto action_17
action_46 _ = happyFail (happyExpListPerState 46)

action_47 (44) = happyShift action_20
action_47 (54) = happyShift action_22
action_47 (58) = happyShift action_23
action_47 (59) = happyShift action_24
action_47 (63) = happyShift action_25
action_47 (64) = happyShift action_26
action_47 (65) = happyShift action_27
action_47 (66) = happyShift action_28
action_47 (67) = happyShift action_29
action_47 (68) = happyShift action_30
action_47 (69) = happyShift action_31
action_47 (6) = happyGoto action_10
action_47 (7) = happyGoto action_11
action_47 (8) = happyGoto action_12
action_47 (9) = happyGoto action_13
action_47 (10) = happyGoto action_14
action_47 (11) = happyGoto action_15
action_47 (12) = happyGoto action_60
action_47 (15) = happyGoto action_17
action_47 _ = happyFail (happyExpListPerState 47)

action_48 (44) = happyShift action_20
action_48 (54) = happyShift action_22
action_48 (58) = happyShift action_23
action_48 (59) = happyShift action_24
action_48 (63) = happyShift action_25
action_48 (64) = happyShift action_26
action_48 (65) = happyShift action_27
action_48 (66) = happyShift action_28
action_48 (67) = happyShift action_29
action_48 (68) = happyShift action_30
action_48 (69) = happyShift action_31
action_48 (6) = happyGoto action_10
action_48 (7) = happyGoto action_11
action_48 (8) = happyGoto action_12
action_48 (9) = happyGoto action_13
action_48 (10) = happyGoto action_14
action_48 (11) = happyGoto action_15
action_48 (12) = happyGoto action_59
action_48 (15) = happyGoto action_17
action_48 _ = happyFail (happyExpListPerState 48)

action_49 (44) = happyShift action_20
action_49 (54) = happyShift action_22
action_49 (58) = happyShift action_23
action_49 (59) = happyShift action_24
action_49 (63) = happyShift action_25
action_49 (64) = happyShift action_26
action_49 (65) = happyShift action_27
action_49 (66) = happyShift action_28
action_49 (67) = happyShift action_29
action_49 (68) = happyShift action_30
action_49 (69) = happyShift action_31
action_49 (6) = happyGoto action_10
action_49 (7) = happyGoto action_11
action_49 (8) = happyGoto action_12
action_49 (9) = happyGoto action_13
action_49 (10) = happyGoto action_14
action_49 (11) = happyGoto action_15
action_49 (12) = happyGoto action_58
action_49 (15) = happyGoto action_17
action_49 _ = happyFail (happyExpListPerState 49)

action_50 (44) = happyShift action_20
action_50 (54) = happyShift action_22
action_50 (58) = happyShift action_23
action_50 (59) = happyShift action_24
action_50 (63) = happyShift action_25
action_50 (64) = happyShift action_26
action_50 (65) = happyShift action_27
action_50 (66) = happyShift action_28
action_50 (67) = happyShift action_29
action_50 (68) = happyShift action_30
action_50 (69) = happyShift action_31
action_50 (6) = happyGoto action_10
action_50 (7) = happyGoto action_11
action_50 (8) = happyGoto action_12
action_50 (9) = happyGoto action_13
action_50 (10) = happyGoto action_14
action_50 (11) = happyGoto action_15
action_50 (12) = happyGoto action_57
action_50 (15) = happyGoto action_17
action_50 _ = happyFail (happyExpListPerState 50)

action_51 (58) = happyShift action_56
action_51 _ = happyFail (happyExpListPerState 51)

action_52 _ = happyReduce_3

action_53 _ = happyReduce_50

action_54 (58) = happyShift action_9
action_54 (21) = happyGoto action_55
action_54 _ = happyFail (happyExpListPerState 54)

action_55 _ = happyReduce_48

action_56 _ = happyReduce_4

action_57 (43) = happyShift action_38
action_57 (44) = happyShift action_39
action_57 (45) = happyShift action_40
action_57 (46) = happyShift action_41
action_57 (47) = happyShift action_42
action_57 (48) = happyShift action_43
action_57 (49) = happyShift action_44
action_57 (50) = happyShift action_45
action_57 (51) = happyShift action_46
action_57 (52) = happyShift action_47
action_57 (53) = happyShift action_48
action_57 (55) = happyShift action_49
action_57 (56) = happyShift action_50
action_57 _ = happyReduce_37

action_58 (43) = happyShift action_38
action_58 (44) = happyShift action_39
action_58 (45) = happyShift action_40
action_58 (46) = happyShift action_41
action_58 (47) = happyShift action_42
action_58 (48) = happyShift action_43
action_58 (49) = happyShift action_44
action_58 (50) = happyShift action_45
action_58 (51) = happyShift action_46
action_58 (52) = happyShift action_47
action_58 (53) = happyShift action_48
action_58 (55) = happyShift action_49
action_58 (56) = happyShift action_50
action_58 _ = happyReduce_36

action_59 (43) = happyShift action_38
action_59 (44) = happyShift action_39
action_59 (45) = happyShift action_40
action_59 (46) = happyShift action_41
action_59 (47) = happyShift action_42
action_59 (48) = happyShift action_43
action_59 (49) = happyShift action_44
action_59 (50) = happyShift action_45
action_59 (51) = happyShift action_46
action_59 (52) = happyShift action_47
action_59 (53) = happyShift action_48
action_59 (55) = happyShift action_49
action_59 (56) = happyShift action_50
action_59 _ = happyReduce_35

action_60 (43) = happyShift action_38
action_60 (44) = happyShift action_39
action_60 (45) = happyShift action_40
action_60 (46) = happyShift action_41
action_60 (47) = happyShift action_42
action_60 (48) = happyShift action_43
action_60 (49) = happyShift action_44
action_60 (50) = happyShift action_45
action_60 (51) = happyShift action_46
action_60 (52) = happyShift action_47
action_60 (53) = happyShift action_48
action_60 (55) = happyShift action_49
action_60 (56) = happyShift action_50
action_60 _ = happyReduce_34

action_61 (43) = happyShift action_38
action_61 (44) = happyShift action_39
action_61 (45) = happyShift action_40
action_61 (46) = happyShift action_41
action_61 (47) = happyShift action_42
action_61 (48) = happyShift action_43
action_61 (49) = happyShift action_44
action_61 (50) = happyShift action_45
action_61 (51) = happyShift action_46
action_61 (52) = happyShift action_47
action_61 (53) = happyShift action_48
action_61 (55) = happyShift action_49
action_61 (56) = happyShift action_50
action_61 _ = happyReduce_33

action_62 (43) = happyShift action_38
action_62 (44) = happyShift action_39
action_62 (45) = happyShift action_40
action_62 (46) = happyShift action_41
action_62 (47) = happyShift action_42
action_62 (48) = happyShift action_43
action_62 (49) = happyShift action_44
action_62 (50) = happyShift action_45
action_62 (51) = happyShift action_46
action_62 (52) = happyShift action_47
action_62 (53) = happyShift action_48
action_62 (55) = happyShift action_49
action_62 (56) = happyShift action_50
action_62 _ = happyReduce_32

action_63 (43) = happyShift action_38
action_63 (44) = happyShift action_39
action_63 (45) = happyShift action_40
action_63 (46) = happyShift action_41
action_63 (47) = happyShift action_42
action_63 (48) = happyShift action_43
action_63 (49) = happyShift action_44
action_63 (50) = happyShift action_45
action_63 (51) = happyShift action_46
action_63 (52) = happyShift action_47
action_63 (53) = happyShift action_48
action_63 (55) = happyShift action_49
action_63 (56) = happyShift action_50
action_63 _ = happyReduce_31

action_64 (43) = happyShift action_38
action_64 (44) = happyShift action_39
action_64 (45) = happyShift action_40
action_64 (46) = happyShift action_41
action_64 (47) = happyShift action_42
action_64 (48) = happyShift action_43
action_64 (49) = happyShift action_44
action_64 (50) = happyShift action_45
action_64 (51) = happyShift action_46
action_64 (52) = happyShift action_47
action_64 (53) = happyShift action_48
action_64 (55) = happyShift action_49
action_64 (56) = happyShift action_50
action_64 _ = happyReduce_30

action_65 (43) = happyShift action_38
action_65 (44) = happyShift action_39
action_65 (45) = happyShift action_40
action_65 (46) = happyShift action_41
action_65 (47) = happyShift action_42
action_65 (48) = happyShift action_43
action_65 (49) = happyShift action_44
action_65 (50) = happyShift action_45
action_65 (51) = happyShift action_46
action_65 (52) = happyShift action_47
action_65 (53) = happyShift action_48
action_65 (55) = happyShift action_49
action_65 (56) = happyShift action_50
action_65 _ = happyReduce_29

action_66 (43) = happyShift action_38
action_66 (44) = happyShift action_39
action_66 (45) = happyShift action_40
action_66 (46) = happyShift action_41
action_66 (47) = happyShift action_42
action_66 (48) = happyShift action_43
action_66 (49) = happyShift action_44
action_66 (50) = happyShift action_45
action_66 (51) = happyShift action_46
action_66 (52) = happyShift action_47
action_66 (53) = happyShift action_48
action_66 (55) = happyShift action_49
action_66 (56) = happyShift action_50
action_66 _ = happyReduce_28

action_67 (43) = happyShift action_38
action_67 (44) = happyShift action_39
action_67 (45) = happyShift action_40
action_67 (46) = happyShift action_41
action_67 (47) = happyShift action_42
action_67 (48) = happyShift action_43
action_67 (49) = happyShift action_44
action_67 (50) = happyShift action_45
action_67 (51) = happyShift action_46
action_67 (52) = happyShift action_47
action_67 (53) = happyShift action_48
action_67 (55) = happyShift action_49
action_67 (56) = happyShift action_50
action_67 _ = happyReduce_27

action_68 (43) = happyShift action_38
action_68 (44) = happyShift action_39
action_68 (45) = happyShift action_40
action_68 (46) = happyShift action_41
action_68 (47) = happyShift action_42
action_68 (48) = happyShift action_43
action_68 (49) = happyShift action_44
action_68 (50) = happyShift action_45
action_68 (51) = happyShift action_46
action_68 (52) = happyShift action_47
action_68 (53) = happyShift action_48
action_68 (55) = happyShift action_49
action_68 (56) = happyShift action_50
action_68 _ = happyReduce_26

action_69 (43) = happyShift action_38
action_69 (44) = happyShift action_39
action_69 (45) = happyShift action_40
action_69 (46) = happyShift action_41
action_69 (47) = happyShift action_42
action_69 (48) = happyShift action_43
action_69 (49) = happyShift action_44
action_69 (50) = happyShift action_45
action_69 (51) = happyShift action_46
action_69 (52) = happyShift action_47
action_69 (53) = happyShift action_48
action_69 (55) = happyShift action_49
action_69 (56) = happyShift action_50
action_69 _ = happyReduce_25

action_70 _ = happyReduce_43

action_71 (43) = happyShift action_38
action_71 (44) = happyShift action_39
action_71 (45) = happyShift action_40
action_71 (46) = happyShift action_41
action_71 (47) = happyShift action_42
action_71 (48) = happyShift action_43
action_71 (49) = happyShift action_44
action_71 (50) = happyShift action_45
action_71 (51) = happyShift action_46
action_71 (52) = happyShift action_47
action_71 (53) = happyShift action_48
action_71 (55) = happyShift action_49
action_71 (56) = happyShift action_50
action_71 _ = happyReduce_24

action_72 (60) = happyShift action_75
action_72 (61) = happyShift action_76
action_72 _ = happyFail (happyExpListPerState 72)

action_73 _ = happyReduce_22

action_74 _ = happyReduce_21

action_75 _ = happyReduce_19

action_76 (44) = happyShift action_20
action_76 (54) = happyShift action_22
action_76 (58) = happyShift action_23
action_76 (59) = happyShift action_24
action_76 (63) = happyShift action_25
action_76 (64) = happyShift action_26
action_76 (65) = happyShift action_27
action_76 (66) = happyShift action_28
action_76 (67) = happyShift action_29
action_76 (68) = happyShift action_30
action_76 (69) = happyShift action_31
action_76 (6) = happyGoto action_10
action_76 (7) = happyGoto action_11
action_76 (8) = happyGoto action_12
action_76 (9) = happyGoto action_13
action_76 (10) = happyGoto action_14
action_76 (11) = happyGoto action_15
action_76 (12) = happyGoto action_71
action_76 (14) = happyGoto action_77
action_76 (15) = happyGoto action_17
action_76 _ = happyFail (happyExpListPerState 76)

action_77 _ = happyReduce_23

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn4
		 (S.Select happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_1  4 happyReduction_2
happyReduction_2 (HappyAbsSyn19  happy_var_1)
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
		 (S.Operator happy_var_1
	)
happyReduction_20 _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  12 happyReduction_21
happyReduction_21 _
	(HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn12
		 (happy_var_2
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_1  13 happyReduction_22
happyReduction_22 (HappyAbsSyn14  happy_var_1)
	 =  HappyAbsSyn13
		 ([ happy_var_1 ]
	)
happyReduction_22 _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  13 happyReduction_23
happyReduction_23 (HappyAbsSyn14  happy_var_3)
	_
	(HappyAbsSyn13  happy_var_1)
	 =  HappyAbsSyn13
		 ((happy_var_3 : happy_var_1)
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_1  14 happyReduction_24
happyReduction_24 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn14
		 (happy_var_1
	)
happyReduction_24 _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  15 happyReduction_25
happyReduction_25 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Plus happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  15 happyReduction_26
happyReduction_26 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Minus happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  15 happyReduction_27
happyReduction_27 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Multiply happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  15 happyReduction_28
happyReduction_28 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.FloatDivide happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  15 happyReduction_29
happyReduction_29 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Modulo happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  15 happyReduction_30
happyReduction_30 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Equals happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  15 happyReduction_31
happyReduction_31 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.NotEquals happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_3  15 happyReduction_32
happyReduction_32 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_32 _ _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_3  15 happyReduction_33
happyReduction_33 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_33 _ _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_3  15 happyReduction_34
happyReduction_34 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_34 _ _ _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  15 happyReduction_35
happyReduction_35 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_3  15 happyReduction_36
happyReduction_36 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.And happy_var_1 happy_var_3
	)
happyReduction_36 _ _ _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_3  15 happyReduction_37
happyReduction_37 (HappyAbsSyn12  happy_var_3)
	_
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn15
		 (S.Or happy_var_1 happy_var_3
	)
happyReduction_37 _ _ _  = notHappyAtAll 

happyReduce_38 = happySpecReduce_2  15 happyReduction_38
happyReduction_38 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Not happy_var_2
	)
happyReduction_38 _ _  = notHappyAtAll 

happyReduce_39 = happySpecReduce_2  15 happyReduction_39
happyReduction_39 (HappyAbsSyn12  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (S.Neg happy_var_2
	)
happyReduction_39 _ _  = notHappyAtAll 

happyReduce_40 = happySpecReduce_2  16 happyReduction_40
happyReduction_40 _
	_
	 =  HappyAbsSyn16
		 (S.Wildcard
	)

happyReduce_41 = happySpecReduce_2  16 happyReduction_41
happyReduction_41 (HappyAbsSyn17  happy_var_2)
	_
	 =  HappyAbsSyn16
		 (S.Columns happy_var_2
	)
happyReduction_41 _ _  = notHappyAtAll 

happyReduce_42 = happySpecReduce_1  17 happyReduction_42
happyReduction_42 (HappyAbsSyn18  happy_var_1)
	 =  HappyAbsSyn17
		 ([happy_var_1]
	)
happyReduction_42 _  = notHappyAtAll 

happyReduce_43 = happySpecReduce_3  17 happyReduction_43
happyReduction_43 (HappyAbsSyn18  happy_var_3)
	_
	(HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn17
		 (happy_var_3 : happy_var_1
	)
happyReduction_43 _ _ _  = notHappyAtAll 

happyReduce_44 = happySpecReduce_1  18 happyReduction_44
happyReduction_44 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 Nothing
	)
happyReduction_44 _  = notHappyAtAll 

happyReduce_45 = happySpecReduce_2  18 happyReduction_45
happyReduction_45 (HappyAbsSyn5  happy_var_2)
	(HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn18
		 (S.Column happy_var_1 happy_var_2
	)
happyReduction_45 _ _  = notHappyAtAll 

happyReduce_46 = happySpecReduce_2  19 happyReduction_46
happyReduction_46 (HappyAbsSyn20  happy_var_2)
	_
	 =  HappyAbsSyn19
		 (happy_var_2
	)
happyReduction_46 _ _  = notHappyAtAll 

happyReduce_47 = happySpecReduce_1  20 happyReduction_47
happyReduction_47 (HappyAbsSyn21  happy_var_1)
	 =  HappyAbsSyn20
		 ([ happy_var_1 ]
	)
happyReduction_47 _  = notHappyAtAll 

happyReduce_48 = happySpecReduce_3  20 happyReduction_48
happyReduction_48 (HappyAbsSyn21  happy_var_3)
	_
	(HappyAbsSyn20  happy_var_1)
	 =  HappyAbsSyn20
		 (happy_var_3 : happy_var_1
	)
happyReduction_48 _ _ _  = notHappyAtAll 

happyReduce_49 = happySpecReduce_1  21 happyReduction_49
happyReduction_49 (HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn21
		 (S.Table happy_var_1 Nothing
	)
happyReduction_49 _  = notHappyAtAll 

happyReduce_50 = happySpecReduce_2  21 happyReduction_50
happyReduction_50 (HappyAbsSyn5  happy_var_2)
	(HappyTerminal (T.Identifier happy_var_1))
	 =  HappyAbsSyn21
		 (S.Table happy_var_1 happy_var_2
	)
happyReduction_50 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 70 70 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	T.Select -> cont 22;
	T.From -> cont 23;
	T.Where -> cont 24;
	T.GroupBy -> cont 25;
	T.Having -> cont 26;
	T.In -> cont 27;
	T.Distinct -> cont 28;
	T.Limit -> cont 29;
	T.OrderBy -> cont 30;
	T.Ascending -> cont 31;
	T.Descending -> cont 32;
	T.Union -> cont 33;
	T.Intersect -> cont 34;
	T.All -> cont 35;
	T.Left -> cont 36;
	T.Right -> cont 37;
	T.Inner -> cont 38;
	T.Outer -> cont 39;
	T.Natural -> cont 40;
	T.Join -> cont 41;
	T.On -> cont 42;
	T.Plus -> cont 43;
	T.Minus -> cont 44;
	T.Asterisk -> cont 45;
	T.FloatDivide -> cont 46;
	T.Modulo -> cont 47;
	T.Equals -> cont 48;
	T.NotEquals -> cont 49;
	T.LT -> cont 50;
	T.LTE -> cont 51;
	T.GT -> cont 52;
	T.GTE -> cont 53;
	T.Not -> cont 54;
	T.And -> cont 55;
	T.Or -> cont 56;
	T.As -> cont 57;
	T.Identifier happy_dollar_dollar -> cont 58;
	T.LeftParen -> cont 59;
	T.RightParen -> cont 60;
	T.Comma -> cont 61;
	T.BlockComment happy_dollar_dollar -> cont 62;
	T.Dotwalk happy_dollar_dollar -> cont 63;
	T.Constant (T.Integer happy_dollar_dollar) -> cont 64;
	T.Constant (T.Float happy_dollar_dollar) -> cont 65;
	T.Constant (T.String happy_dollar_dollar) -> cont 66;
	T.Constant (T.Boolean T.TrueVal) -> cont 67;
	T.Constant (T.Boolean T.FalseVal) -> cont 68;
	T.Constant (T.Boolean T.Null ) -> cont 69;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 70 tk tks = happyError' (tks, explist)
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
