{-# OPTIONS_GHC -w #-}
module Parser 
    ( parse

    ) where

import Parser.Syntax
import Parser.Syntax as S
import Lexer.Tokens
import qualified Data.Array as Happy_Data_Array
import qualified Data.Bits as Bits
import Control.Applicative(Applicative(..))
import Control.Monad (ap)

-- parser produced by Happy Version 1.19.9

data HappyAbsSyn t4 t15 t16 t17
	= HappyTerminal (Token)
	| HappyErrorToken Int
	| HappyAbsSyn4 t4
	| HappyAbsSyn5 (Select)
	| HappyAbsSyn6 (Columns)
	| HappyAbsSyn7 (Column)
	| HappyAbsSyn8 (Alias)
	| HappyAbsSyn9 (Expr)
	| HappyAbsSyn10 (Fn)
	| HappyAbsSyn11 (Args)
	| HappyAbsSyn12 (Arg)
	| HappyAbsSyn15 t15
	| HappyAbsSyn16 t16
	| HappyAbsSyn17 t17

happyExpList :: Happy_Data_Array.Array Int Int
happyExpList = Happy_Data_Array.listArray (0,157) ([0,2,0,0,16384,0,0,0,0,0,0,0,0,32768,12288,0,0,0,0,0,0,0,1024,0,0,0,0,0,0,61438,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,88,0,0,0,0,0,0,0,0,0,0,2048,0,0,0,0,0,0,0,96,0,0,0,0,0,0,32768,1,0,0,12288,0,0,0,1536,0,0,0,192,0,0,0,24,0,0,0,3,0,0,24576,0,0,0,3072,0,0,0,384,0,0,0,48,0,0,0,6,0,0,49152,0,0,0,6144,0,0,0,768,0,0,0,0,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,65024,111,0,0,0,768,0,0,0,0,0,0,0,2,0,0,0,0,0,0,0,0,0,0,192,0,0,0,0,0
	])

{-# NOINLINE happyExpListPerState #-}
happyExpListPerState st =
    token_strs_expected
  where token_strs = ["error","%dummy","%start_parse","Query","Select","Columns","Column","Alias","Expr","Function","Args","Arg","BinaryOp","UnaryOp","From","Tables","Table","select","from","where","groupBy","having","in","distinct","limit","orderBy","asc","desc","union","intersect","all","left","right","inner","outer","natural","join","on","'+'","'-'","'*'","'/'","'%'","'='","'!='","'<'","'<='","'>'","'>='","not","and","or","as","identifier","constant","'('","')'","','","lc","bc","%eof"]
        bit_start = st * 61
        bit_end = (st + 1) * 61
        read_bit = readArrayBit happyExpList
        bits = map read_bit [bit_start..bit_end - 1]
        bits_indexed = zip bits [0..60]
        token_strs_expected = concatMap f bits_indexed
        f (False, _) = []
        f (True, nr) = [token_strs !! nr]

action_0 (18) = happyShift action_3
action_0 (4) = happyGoto action_4
action_0 (5) = happyGoto action_2
action_0 _ = happyFail (happyExpListPerState 0)

action_1 (18) = happyShift action_3
action_1 (5) = happyGoto action_2
action_1 _ = happyFail (happyExpListPerState 1)

action_2 _ = happyReduce_1

action_3 (41) = happyShift action_10
action_3 (54) = happyShift action_11
action_3 (55) = happyShift action_12
action_3 (6) = happyGoto action_5
action_3 (7) = happyGoto action_6
action_3 (9) = happyGoto action_7
action_3 (10) = happyGoto action_8
action_3 (13) = happyGoto action_9
action_3 _ = happyFail (happyExpListPerState 3)

action_4 (61) = happyAccept
action_4 _ = happyFail (happyExpListPerState 4)

action_5 (58) = happyShift action_31
action_5 _ = happyReduce_3

action_6 _ = happyReduce_4

action_7 (39) = happyShift action_18
action_7 (40) = happyShift action_19
action_7 (41) = happyShift action_20
action_7 (42) = happyShift action_21
action_7 (43) = happyShift action_22
action_7 (44) = happyShift action_23
action_7 (45) = happyShift action_24
action_7 (46) = happyShift action_25
action_7 (47) = happyShift action_26
action_7 (48) = happyShift action_27
action_7 (49) = happyShift action_28
action_7 (51) = happyShift action_29
action_7 (52) = happyShift action_30
action_7 (53) = happyShift action_14
action_7 (54) = happyShift action_15
action_7 (8) = happyGoto action_17
action_7 _ = happyFail (happyExpListPerState 7)

action_8 _ = happyReduce_11

action_9 _ = happyReduce_13

action_10 _ = happyReduce_2

action_11 (53) = happyShift action_14
action_11 (54) = happyShift action_15
action_11 (56) = happyShift action_16
action_11 (8) = happyGoto action_13
action_11 _ = happyReduce_6

action_12 _ = happyReduce_12

action_13 _ = happyReduce_7

action_14 (54) = happyShift action_51
action_14 _ = happyFail (happyExpListPerState 14)

action_15 _ = happyReduce_9

action_16 (54) = happyShift action_50
action_16 (55) = happyShift action_12
action_16 (9) = happyGoto action_47
action_16 (10) = happyGoto action_8
action_16 (11) = happyGoto action_48
action_16 (12) = happyGoto action_49
action_16 (13) = happyGoto action_9
action_16 _ = happyFail (happyExpListPerState 16)

action_17 _ = happyReduce_8

action_18 (54) = happyShift action_34
action_18 (55) = happyShift action_12
action_18 (9) = happyGoto action_46
action_18 (10) = happyGoto action_8
action_18 (13) = happyGoto action_9
action_18 _ = happyFail (happyExpListPerState 18)

action_19 (54) = happyShift action_34
action_19 (55) = happyShift action_12
action_19 (9) = happyGoto action_45
action_19 (10) = happyGoto action_8
action_19 (13) = happyGoto action_9
action_19 _ = happyFail (happyExpListPerState 19)

action_20 (54) = happyShift action_34
action_20 (55) = happyShift action_12
action_20 (9) = happyGoto action_44
action_20 (10) = happyGoto action_8
action_20 (13) = happyGoto action_9
action_20 _ = happyFail (happyExpListPerState 20)

action_21 (54) = happyShift action_34
action_21 (55) = happyShift action_12
action_21 (9) = happyGoto action_43
action_21 (10) = happyGoto action_8
action_21 (13) = happyGoto action_9
action_21 _ = happyFail (happyExpListPerState 21)

action_22 (54) = happyShift action_34
action_22 (55) = happyShift action_12
action_22 (9) = happyGoto action_42
action_22 (10) = happyGoto action_8
action_22 (13) = happyGoto action_9
action_22 _ = happyFail (happyExpListPerState 22)

action_23 (54) = happyShift action_34
action_23 (55) = happyShift action_12
action_23 (9) = happyGoto action_41
action_23 (10) = happyGoto action_8
action_23 (13) = happyGoto action_9
action_23 _ = happyFail (happyExpListPerState 23)

action_24 (54) = happyShift action_34
action_24 (55) = happyShift action_12
action_24 (9) = happyGoto action_40
action_24 (10) = happyGoto action_8
action_24 (13) = happyGoto action_9
action_24 _ = happyFail (happyExpListPerState 24)

action_25 (54) = happyShift action_34
action_25 (55) = happyShift action_12
action_25 (9) = happyGoto action_39
action_25 (10) = happyGoto action_8
action_25 (13) = happyGoto action_9
action_25 _ = happyFail (happyExpListPerState 25)

action_26 (54) = happyShift action_34
action_26 (55) = happyShift action_12
action_26 (9) = happyGoto action_38
action_26 (10) = happyGoto action_8
action_26 (13) = happyGoto action_9
action_26 _ = happyFail (happyExpListPerState 26)

action_27 (54) = happyShift action_34
action_27 (55) = happyShift action_12
action_27 (9) = happyGoto action_37
action_27 (10) = happyGoto action_8
action_27 (13) = happyGoto action_9
action_27 _ = happyFail (happyExpListPerState 27)

action_28 (54) = happyShift action_34
action_28 (55) = happyShift action_12
action_28 (9) = happyGoto action_36
action_28 (10) = happyGoto action_8
action_28 (13) = happyGoto action_9
action_28 _ = happyFail (happyExpListPerState 28)

action_29 (54) = happyShift action_34
action_29 (55) = happyShift action_12
action_29 (9) = happyGoto action_35
action_29 (10) = happyGoto action_8
action_29 (13) = happyGoto action_9
action_29 _ = happyFail (happyExpListPerState 29)

action_30 (54) = happyShift action_34
action_30 (55) = happyShift action_12
action_30 (9) = happyGoto action_33
action_30 (10) = happyGoto action_8
action_30 (13) = happyGoto action_9
action_30 _ = happyFail (happyExpListPerState 30)

action_31 (54) = happyShift action_11
action_31 (55) = happyShift action_12
action_31 (7) = happyGoto action_32
action_31 (9) = happyGoto action_7
action_31 (10) = happyGoto action_8
action_31 (13) = happyGoto action_9
action_31 _ = happyFail (happyExpListPerState 31)

action_32 _ = happyReduce_5

action_33 (39) = happyShift action_18
action_33 (40) = happyShift action_19
action_33 (41) = happyShift action_20
action_33 (42) = happyShift action_21
action_33 (43) = happyShift action_22
action_33 (44) = happyShift action_23
action_33 (45) = happyShift action_24
action_33 (46) = happyShift action_25
action_33 (47) = happyShift action_26
action_33 (48) = happyShift action_27
action_33 (49) = happyShift action_28
action_33 (51) = happyShift action_29
action_33 (52) = happyShift action_30
action_33 _ = happyReduce_31

action_34 (56) = happyShift action_16
action_34 _ = happyFail (happyExpListPerState 34)

action_35 (39) = happyShift action_18
action_35 (40) = happyShift action_19
action_35 (41) = happyShift action_20
action_35 (42) = happyShift action_21
action_35 (43) = happyShift action_22
action_35 (44) = happyShift action_23
action_35 (45) = happyShift action_24
action_35 (46) = happyShift action_25
action_35 (47) = happyShift action_26
action_35 (48) = happyShift action_27
action_35 (49) = happyShift action_28
action_35 (51) = happyShift action_29
action_35 (52) = happyShift action_30
action_35 _ = happyReduce_30

action_36 (39) = happyShift action_18
action_36 (40) = happyShift action_19
action_36 (41) = happyShift action_20
action_36 (42) = happyShift action_21
action_36 (43) = happyShift action_22
action_36 (44) = happyShift action_23
action_36 (45) = happyShift action_24
action_36 (46) = happyShift action_25
action_36 (47) = happyShift action_26
action_36 (48) = happyShift action_27
action_36 (49) = happyShift action_28
action_36 (51) = happyShift action_29
action_36 (52) = happyShift action_30
action_36 _ = happyReduce_29

action_37 (39) = happyShift action_18
action_37 (40) = happyShift action_19
action_37 (41) = happyShift action_20
action_37 (42) = happyShift action_21
action_37 (43) = happyShift action_22
action_37 (44) = happyShift action_23
action_37 (45) = happyShift action_24
action_37 (46) = happyShift action_25
action_37 (47) = happyShift action_26
action_37 (48) = happyShift action_27
action_37 (49) = happyShift action_28
action_37 (51) = happyShift action_29
action_37 (52) = happyShift action_30
action_37 _ = happyReduce_28

action_38 (39) = happyShift action_18
action_38 (40) = happyShift action_19
action_38 (41) = happyShift action_20
action_38 (42) = happyShift action_21
action_38 (43) = happyShift action_22
action_38 (44) = happyShift action_23
action_38 (45) = happyShift action_24
action_38 (46) = happyShift action_25
action_38 (47) = happyShift action_26
action_38 (48) = happyShift action_27
action_38 (49) = happyShift action_28
action_38 (51) = happyShift action_29
action_38 (52) = happyShift action_30
action_38 _ = happyReduce_27

action_39 (39) = happyShift action_18
action_39 (40) = happyShift action_19
action_39 (41) = happyShift action_20
action_39 (42) = happyShift action_21
action_39 (43) = happyShift action_22
action_39 (44) = happyShift action_23
action_39 (45) = happyShift action_24
action_39 (46) = happyShift action_25
action_39 (47) = happyShift action_26
action_39 (48) = happyShift action_27
action_39 (49) = happyShift action_28
action_39 (51) = happyShift action_29
action_39 (52) = happyShift action_30
action_39 _ = happyReduce_26

action_40 (39) = happyShift action_18
action_40 (40) = happyShift action_19
action_40 (41) = happyShift action_20
action_40 (42) = happyShift action_21
action_40 (43) = happyShift action_22
action_40 (44) = happyShift action_23
action_40 (45) = happyShift action_24
action_40 (46) = happyShift action_25
action_40 (47) = happyShift action_26
action_40 (48) = happyShift action_27
action_40 (49) = happyShift action_28
action_40 (51) = happyShift action_29
action_40 (52) = happyShift action_30
action_40 _ = happyReduce_25

action_41 (39) = happyShift action_18
action_41 (40) = happyShift action_19
action_41 (41) = happyShift action_20
action_41 (42) = happyShift action_21
action_41 (43) = happyShift action_22
action_41 (44) = happyShift action_23
action_41 (45) = happyShift action_24
action_41 (46) = happyShift action_25
action_41 (47) = happyShift action_26
action_41 (48) = happyShift action_27
action_41 (49) = happyShift action_28
action_41 (51) = happyShift action_29
action_41 (52) = happyShift action_30
action_41 _ = happyReduce_24

action_42 (39) = happyShift action_18
action_42 (40) = happyShift action_19
action_42 (41) = happyShift action_20
action_42 (42) = happyShift action_21
action_42 (43) = happyShift action_22
action_42 (44) = happyShift action_23
action_42 (45) = happyShift action_24
action_42 (46) = happyShift action_25
action_42 (47) = happyShift action_26
action_42 (48) = happyShift action_27
action_42 (49) = happyShift action_28
action_42 (51) = happyShift action_29
action_42 (52) = happyShift action_30
action_42 _ = happyReduce_23

action_43 (39) = happyShift action_18
action_43 (40) = happyShift action_19
action_43 (41) = happyShift action_20
action_43 (42) = happyShift action_21
action_43 (43) = happyShift action_22
action_43 (44) = happyShift action_23
action_43 (45) = happyShift action_24
action_43 (46) = happyShift action_25
action_43 (47) = happyShift action_26
action_43 (48) = happyShift action_27
action_43 (49) = happyShift action_28
action_43 (51) = happyShift action_29
action_43 (52) = happyShift action_30
action_43 _ = happyReduce_22

action_44 (39) = happyShift action_18
action_44 (40) = happyShift action_19
action_44 (41) = happyShift action_20
action_44 (42) = happyShift action_21
action_44 (43) = happyShift action_22
action_44 (44) = happyShift action_23
action_44 (45) = happyShift action_24
action_44 (46) = happyShift action_25
action_44 (47) = happyShift action_26
action_44 (48) = happyShift action_27
action_44 (49) = happyShift action_28
action_44 (51) = happyShift action_29
action_44 (52) = happyShift action_30
action_44 _ = happyReduce_21

action_45 (39) = happyShift action_18
action_45 (40) = happyShift action_19
action_45 (41) = happyShift action_20
action_45 (42) = happyShift action_21
action_45 (43) = happyShift action_22
action_45 (44) = happyShift action_23
action_45 (45) = happyShift action_24
action_45 (46) = happyShift action_25
action_45 (47) = happyShift action_26
action_45 (48) = happyShift action_27
action_45 (49) = happyShift action_28
action_45 (51) = happyShift action_29
action_45 (52) = happyShift action_30
action_45 _ = happyReduce_20

action_46 (39) = happyShift action_18
action_46 (40) = happyShift action_19
action_46 (41) = happyShift action_20
action_46 (42) = happyShift action_21
action_46 (43) = happyShift action_22
action_46 (44) = happyShift action_23
action_46 (45) = happyShift action_24
action_46 (46) = happyShift action_25
action_46 (47) = happyShift action_26
action_46 (48) = happyShift action_27
action_46 (49) = happyShift action_28
action_46 (51) = happyShift action_29
action_46 (52) = happyShift action_30
action_46 _ = happyReduce_19

action_47 (39) = happyShift action_18
action_47 (40) = happyShift action_19
action_47 (41) = happyShift action_20
action_47 (42) = happyShift action_21
action_47 (43) = happyShift action_22
action_47 (44) = happyShift action_23
action_47 (45) = happyShift action_24
action_47 (46) = happyShift action_25
action_47 (47) = happyShift action_26
action_47 (48) = happyShift action_27
action_47 (49) = happyShift action_28
action_47 (51) = happyShift action_29
action_47 (52) = happyShift action_30
action_47 _ = happyReduce_18

action_48 (57) = happyShift action_52
action_48 (58) = happyShift action_53
action_48 _ = happyFail (happyExpListPerState 48)

action_49 _ = happyReduce_15

action_50 (56) = happyShift action_16
action_50 _ = happyReduce_17

action_51 _ = happyReduce_10

action_52 _ = happyReduce_14

action_53 (54) = happyShift action_50
action_53 (55) = happyShift action_12
action_53 (9) = happyGoto action_47
action_53 (10) = happyGoto action_8
action_53 (12) = happyGoto action_54
action_53 (13) = happyGoto action_9
action_53 _ = happyFail (happyExpListPerState 53)

action_54 _ = happyReduce_16

happyReduce_1 = happySpecReduce_1  4 happyReduction_1
happyReduction_1 (HappyAbsSyn5  happy_var_1)
	 =  HappyAbsSyn4
		 (QuerySelect happy_var_1
	)
happyReduction_1 _  = notHappyAtAll 

happyReduce_2 = happySpecReduce_2  5 happyReduction_2
happyReduction_2 _
	_
	 =  HappyAbsSyn5
		 (Select Wildcard
	)

happyReduce_3 = happySpecReduce_2  5 happyReduction_3
happyReduction_3 (HappyAbsSyn6  happy_var_2)
	_
	 =  HappyAbsSyn5
		 (Select (Columns happy_var_2)
	)
happyReduction_3 _ _  = notHappyAtAll 

happyReduce_4 = happySpecReduce_1  6 happyReduction_4
happyReduction_4 (HappyAbsSyn7  happy_var_1)
	 =  HappyAbsSyn6
		 ([happy_var_1]
	)
happyReduction_4 _  = notHappyAtAll 

happyReduce_5 = happySpecReduce_3  6 happyReduction_5
happyReduction_5 _
	(HappyTerminal happy_var_2)
	(HappyAbsSyn6  happy_var_1)
	 =  HappyAbsSyn6
		 (happy_var_2 : happy_var_1
	)
happyReduction_5 _ _ _  = notHappyAtAll 

happyReduce_6 = happySpecReduce_1  7 happyReduction_6
happyReduction_6 (HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn7
		 (Column (Identifier happy_var_1) Nothing
	)
happyReduction_6 _  = notHappyAtAll 

happyReduce_7 = happySpecReduce_2  7 happyReduction_7
happyReduction_7 (HappyAbsSyn8  happy_var_2)
	(HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn7
		 (Column (Identifier happy_var_1) happy_var_2
	)
happyReduction_7 _ _  = notHappyAtAll 

happyReduce_8 = happySpecReduce_2  7 happyReduction_8
happyReduction_8 (HappyAbsSyn8  happy_var_2)
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn7
		 (Column (Expr happy_var_1) happy_var_2
	)
happyReduction_8 _ _  = notHappyAtAll 

happyReduce_9 = happySpecReduce_1  8 happyReduction_9
happyReduction_9 (HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn8
		 (Just happy_var_1
	)
happyReduction_9 _  = notHappyAtAll 

happyReduce_10 = happySpecReduce_2  8 happyReduction_10
happyReduction_10 (HappyTerminal (TokenIdentifier happy_var_2))
	_
	 =  HappyAbsSyn8
		 (Just happy_var_2
	)
happyReduction_10 _ _  = notHappyAtAll 

happyReduce_11 = happySpecReduce_1  9 happyReduction_11
happyReduction_11 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (Expr happy_var_1
	)
happyReduction_11 _  = notHappyAtAll 

happyReduce_12 = happySpecReduce_1  9 happyReduction_12
happyReduction_12 (HappyTerminal (TokenConstant happy_var_1))
	 =  HappyAbsSyn9
		 (Expr (Constant happy_var_1)
	)
happyReduction_12 _  = notHappyAtAll 

happyReduce_13 = happySpecReduce_1  9 happyReduction_13
happyReduction_13 (HappyAbsSyn10  happy_var_1)
	 =  HappyAbsSyn9
		 (Expr happy_var_1
	)
happyReduction_13 _  = notHappyAtAll 

happyReduce_14 = happyReduce 4 10 happyReduction_14
happyReduction_14 (_ `HappyStk`
	(HappyAbsSyn11  happy_var_3) `HappyStk`
	_ `HappyStk`
	(HappyTerminal (TokenIdentifier happy_var_1)) `HappyStk`
	happyRest)
	 = HappyAbsSyn10
		 (Function (Identifier happy_var_1) happy_var_3
	) `HappyStk` happyRest

happyReduce_15 = happySpecReduce_1  11 happyReduction_15
happyReduction_15 (HappyAbsSyn12  happy_var_1)
	 =  HappyAbsSyn11
		 (Arg [happy_var_1]
	)
happyReduction_15 _  = notHappyAtAll 

happyReduce_16 = happySpecReduce_3  11 happyReduction_16
happyReduction_16 _
	(HappyTerminal happy_var_2)
	(HappyAbsSyn11  happy_var_1)
	 =  HappyAbsSyn11
		 (happy_var_2:happy_var_1
	)
happyReduction_16 _ _ _  = notHappyAtAll 

happyReduce_17 = happySpecReduce_1  12 happyReduction_17
happyReduction_17 (HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn12
		 (Identifier happy_var_1
	)
happyReduction_17 _  = notHappyAtAll 

happyReduce_18 = happySpecReduce_1  12 happyReduction_18
happyReduction_18 (HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn12
		 (happy_var_1
	)
happyReduction_18 _  = notHappyAtAll 

happyReduce_19 = happySpecReduce_3  13 happyReduction_19
happyReduction_19 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Plus happy_var_1 happy_var_3
	)
happyReduction_19 _ _ _  = notHappyAtAll 

happyReduce_20 = happySpecReduce_3  13 happyReduction_20
happyReduction_20 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Minus happy_var_1 happy_var_3
	)
happyReduction_20 _ _ _  = notHappyAtAll 

happyReduce_21 = happySpecReduce_3  13 happyReduction_21
happyReduction_21 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Multiply happy_var_1 happy_var_3
	)
happyReduction_21 _ _ _  = notHappyAtAll 

happyReduce_22 = happySpecReduce_3  13 happyReduction_22
happyReduction_22 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (FloatDivide happy_var_1 happy_var_3
	)
happyReduction_22 _ _ _  = notHappyAtAll 

happyReduce_23 = happySpecReduce_3  13 happyReduction_23
happyReduction_23 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Modulo happy_var_1 happy_var_3
	)
happyReduction_23 _ _ _  = notHappyAtAll 

happyReduce_24 = happySpecReduce_3  13 happyReduction_24
happyReduction_24 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Equals happy_var_1 happy_var_3
	)
happyReduction_24 _ _ _  = notHappyAtAll 

happyReduce_25 = happySpecReduce_3  13 happyReduction_25
happyReduction_25 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (NotEquals happy_var_1 happy_var_3
	)
happyReduction_25 _ _ _  = notHappyAtAll 

happyReduce_26 = happySpecReduce_3  13 happyReduction_26
happyReduction_26 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (S.LT happy_var_1 happy_var_3
	)
happyReduction_26 _ _ _  = notHappyAtAll 

happyReduce_27 = happySpecReduce_3  13 happyReduction_27
happyReduction_27 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (S.LTE happy_var_1 happy_var_3
	)
happyReduction_27 _ _ _  = notHappyAtAll 

happyReduce_28 = happySpecReduce_3  13 happyReduction_28
happyReduction_28 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (S.GT happy_var_1 happy_var_3
	)
happyReduction_28 _ _ _  = notHappyAtAll 

happyReduce_29 = happySpecReduce_3  13 happyReduction_29
happyReduction_29 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (S.GTE happy_var_1 happy_var_3
	)
happyReduction_29 _ _ _  = notHappyAtAll 

happyReduce_30 = happySpecReduce_3  13 happyReduction_30
happyReduction_30 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (And happy_var_1 happy_var_3
	)
happyReduction_30 _ _ _  = notHappyAtAll 

happyReduce_31 = happySpecReduce_3  13 happyReduction_31
happyReduction_31 (HappyAbsSyn9  happy_var_3)
	_
	(HappyAbsSyn9  happy_var_1)
	 =  HappyAbsSyn10
		 (Or happy_var_1 happy_var_3
	)
happyReduction_31 _ _ _  = notHappyAtAll 

happyReduce_32 = happySpecReduce_2  14 happyReduction_32
happyReduction_32 (HappyAbsSyn9  happy_var_2)
	_
	 =  HappyAbsSyn10
		 (Not happy_var_2
	)
happyReduction_32 _ _  = notHappyAtAll 

happyReduce_33 = happySpecReduce_2  15 happyReduction_33
happyReduction_33 (HappyAbsSyn16  happy_var_2)
	_
	 =  HappyAbsSyn15
		 (From happy_var_2
	)
happyReduction_33 _ _  = notHappyAtAll 

happyReduce_34 = happySpecReduce_1  16 happyReduction_34
happyReduction_34 (HappyAbsSyn17  happy_var_1)
	 =  HappyAbsSyn16
		 ([happy_var_1]
	)
happyReduction_34 _  = notHappyAtAll 

happyReduce_35 = happySpecReduce_3  16 happyReduction_35
happyReduction_35 _
	(HappyTerminal happy_var_2)
	(HappyAbsSyn16  happy_var_1)
	 =  HappyAbsSyn16
		 (happy_var_2 : happy_var_1
	)
happyReduction_35 _ _ _  = notHappyAtAll 

happyReduce_36 = happySpecReduce_1  17 happyReduction_36
happyReduction_36 (HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn17
		 (Table happy_var_1 Nothing
	)
happyReduction_36 _  = notHappyAtAll 

happyReduce_37 = happySpecReduce_2  17 happyReduction_37
happyReduction_37 (HappyAbsSyn8  happy_var_2)
	(HappyTerminal (TokenIdentifier happy_var_1))
	 =  HappyAbsSyn17
		 (Table happy_var_1 happy_var_2
	)
happyReduction_37 _ _  = notHappyAtAll 

happyNewToken action sts stk [] =
	action 61 61 notHappyAtAll (HappyState action) sts stk []

happyNewToken action sts stk (tk:tks) =
	let cont i = action i i tk (HappyState action) sts stk tks in
	case tk of {
	TokenSelect -> cont 18;
	TokenFrom -> cont 19;
	TokenWhere -> cont 20;
	TokenGroupBy -> cont 21;
	TokenHaving -> cont 22;
	TokenIn -> cont 23;
	TokenDistinct -> cont 24;
	TokenLimit -> cont 25;
	TokenOrderBy -> cont 26;
	TokenAscending -> cont 27;
	TokenDescending -> cont 28;
	TokenUnion -> cont 29;
	TokenIntersect -> cont 30;
	TokenAll -> cont 31;
	TokenLeft -> cont 32;
	TokenRight -> cont 33;
	TokenInner -> cont 34;
	TokenOuter -> cont 35;
	TokenNatural -> cont 36;
	TokenJoin -> cont 37;
	TokenOn -> cont 38;
	TokenPlus -> cont 39;
	TokenMinus -> cont 40;
	TokenAsterisk -> cont 41;
	TokenFloatDivide -> cont 42;
	TokenModulo -> cont 43;
	TokenEquals -> cont 44;
	TokenNotEquals -> cont 45;
	TokenLT -> cont 46;
	TokenLTE -> cont 47;
	TokenGT -> cont 48;
	TokenGTE -> cont 49;
	TokenNot -> cont 50;
	TokenAnd -> cont 51;
	TokenOr -> cont 52;
	TokenAs -> cont 53;
	TokenIdentifier happy_dollar_dollar -> cont 54;
	TokenConstant happy_dollar_dollar -> cont 55;
	TokenRightParen -> cont 56;
	TokenLeftParen -> cont 57;
	TokenComma -> cont 58;
	TokenLineComment happy_dollar_dollar -> cont 59;
	TokenBlockComment happy_dollar_dollar -> cont 60;
	_ -> happyError' ((tk:tks), [])
	}

happyError_ explist 61 tk tks = happyError' (tks, explist)
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
happyError' :: () => ([(Token)], [String]) -> HappyIdentity a
happyError' = HappyIdentity . (\(tokens, _) -> parseError tokens)
parse tks = happyRunIdentity happySomeParser where
 happySomeParser = happyThen (happyParse action_0 tks) (\x -> case x of {HappyAbsSyn4 z -> happyReturn z; _other -> notHappyAtAll })

happySeq = happyDontSeq



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
