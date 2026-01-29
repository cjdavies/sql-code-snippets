/* Get list of values for xtype used in sysobjects */
SELECT name
  FROM master..spt_values
 WHERE type   = 'O9T'
   AND number = '-1';