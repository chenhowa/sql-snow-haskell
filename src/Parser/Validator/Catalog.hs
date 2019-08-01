module Parser.Validator.Catalog where
    
import qualified Data.Map.Strict as Map

data Column
    = Column
        { cName :: String
        , table :: Maybe String
        }

data Table 
    = Table 
        { tName :: String
        , alias :: Maybe String
        }

type TableName = String
type ColumnName = String
type Error = String

data CheckResult
    = CheckResult 
        { map :: Map.Map TableName [ColumnName]

        }

verify :: [Column] -> [Table] -> Either Error CheckResult
verify cols tables = Left "no columns and tables currently available; not connected to database"