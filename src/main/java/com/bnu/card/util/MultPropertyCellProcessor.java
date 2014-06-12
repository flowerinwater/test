package com.bnu.card.util;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.Map.Entry;
import net.sf.jxls.parser.Cell;
import net.sf.jxls.processor.CellProcessor;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.util.CellRangeAddress;
/**
 * 多属性合并单元格转换器
 * @author ydw
 *
 */
public class MultPropertyCellProcessor implements CellProcessor {
 /**
  * 合并属性集
  */
 private String[] keys;
 /**
  * 合并数据集
  */
 private Map<String, List<ExcelColumn>> mergedMap = new HashMap<String, List<ExcelColumn>>();
 /**
  * 合并属性的起始行列
  */
 private Map<String, ExcelColumn> first = new HashMap<String, ExcelColumn>();
 public MultPropertyCellProcessor(String[] keys) {
  this.keys = keys;
 }
 /** 
  *  刚开始不明白这个Map namedCells参数的含义，通过跟踪源代码发现是下面类调用的
  *  SimpleRowTransformer
  *  private void applyCellProcessors(Sheet sheet, Cell cell) {
     for (int i = 0; i < cellProcessors.size(); i++) {
         CellProcessor cellProcessor = (CellProcessor) cellProcessors.get(i);
         cellProcessor.processCell(cell, sheet.getNamedCells());
     }
 }
  */
 @Override
 public void processCell(Cell cell, Map namedCells) {
  for (String key : keys) {
   if (cell.getStringCellValue().contains(key)) {
    first.put(key,
      new ExcelColumn(key, cell.getPoiCell().getRowIndex(), cell.getPoiCell().getColumnIndex()));
   }
  }
  //同行列，实际数据，不是表达式值
  for (String key : keys) {
   int firstRow = first.get(key) == null ? -1 : first.get(key).getRow();
   int firstCol = first.get(key) == null ? -1 : first.get(key).getCol();
   if (cell.getPoiCell().getRowIndex() == firstRow && cell.getPoiCell().getColumnIndex() == firstCol
     && !cell.getStringCellValue().contains(key)) {
    String value = cell.getStringCellValue();
    //由属性+值构成键
    String tmpKey = key + "_" + value;
    if (mergedMap.containsKey(tmpKey)) {
     mergedMap.get(tmpKey).add(new ExcelColumn(value, firstRow, firstCol));
    } else {
     List<ExcelColumn> list = new ArrayList<ExcelColumn>();
     list.add(new ExcelColumn(value, firstRow, firstCol));
     mergedMap.put(tmpKey, list);
    }
   }
   merged(cell.getPoiCell().getSheet(), mergedMap);
  }
 }
 private void merged(Sheet sheet, Map<String, List<ExcelColumn>> map) {
  Set<Entry<String, List<ExcelColumn>>> set = map.entrySet();
  for (Entry<String, List<ExcelColumn>> entry : set) {
   String tmpKey = entry.getKey();
   int firstRow = 9999;
   int lastRow = -1;
   int colindex = 0;
   for (ExcelColumn col : map.get(tmpKey)) {
    colindex = col.getCol();
    if (col.getRow() < firstRow)
     firstRow = col.getRow();
    if (col.getRow() > lastRow)
     lastRow = col.getRow();
   }
   CellRangeAddress range = new CellRangeAddress(firstRow, lastRow, colindex, colindex);
   sheet.addMergedRegion(range);
  }
 }
}
