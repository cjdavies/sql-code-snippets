DECLARE                                                
  @CchvCrLf   VARCHAR(2)    = CHAR(13) + CHAR(10) ,
  @chvErrMsg  VARCHAR(2048)                       ;
 
-- Code here
 
BEGIN CATCH;
-- Jim Riedemann: The format of the errMsg contents matches a standard SQL error message at the console.
  SELECT
    @chvErrMsg  = 'Msg ' + CONVERT(VARCHAR(12), ERROR_NUMBER()) + ', ' +
                  'Level ' + CONVERT(VARCHAR(12), ERROR_SEVERITY()) + ', ' +
                  'State ' + CONVERT(VARCHAR(12), ERROR_STATE()) + ', ' +
                  'Procedure ' + ISNULL(ERROR_PROCEDURE(), 'Unknown') + ', ' +
                  'Line ' + CONVERT(VARCHAR(12), ERROR_LINE()) + @CchvCrLf +
                  ERROR_MESSAGE();
  -- Do other stuff here...
  RAISERROR(@chvErrMsg, 0, -1) WITH NOWAIT;
END CATCH;