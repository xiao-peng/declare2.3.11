package bjrxht.poi

import org.apache.poi.extractor.ExtractorFactory
import org.apache.poi.hwpf.HWPFDocumentCore
import org.apache.poi.hwpf.converter.WordToHtmlConverter
import org.apache.poi.hwpf.converter.WordToHtmlUtils
import org.apache.poi.xwpf.usermodel.Document

import javax.xml.parsers.DocumentBuilderFactory
import javax.xml.transform.OutputKeys
import javax.xml.transform.Transformer
import javax.xml.transform.TransformerFactory
import javax.xml.transform.dom.DOMSource
import javax.xml.transform.stream.StreamResult

/**
 * Created by Administrator on 2014/12/9.
 */

//@Grab(group='org.apache.poi', module='poi', version='3.7')
//@Grab(group='org.apache.poi', module='poi-ooxml', version='3.7')
//@Grab(group='org.apache.poi', module='poi-scratchpad', version='3.7')
class WordReadBuilder {
    public void transToHtml(File file){
        HWPFDocumentCore wordDocument = WordToHtmlUtils.loadDoc(new FileInputStream("D:\\temp\\seo\\1.doc"));

        WordToHtmlConverter wordToHtmlConverter = new WordToHtmlConverter(DocumentBuilderFactory.newInstance().newDocumentBuilder().newDocument());
        wordToHtmlConverter.processDocument(wordDocument);
        Document htmlDocument = wordToHtmlConverter.getDocument();
        ByteArrayOutputStream out = new ByteArrayOutputStream();
        DOMSource domSource = new DOMSource(htmlDocument);
        StreamResult streamResult = new StreamResult(out);

        TransformerFactory tf = TransformerFactory.newInstance();
        Transformer serializer = tf.newTransformer();
        serializer.setOutputProperty(OutputKeys.ENCODING, "UTF-8");
        serializer.setOutputProperty(OutputKeys.INDENT, "yes");
        serializer.setOutputProperty(OutputKeys.METHOD, "html");
        serializer.transform(domSource, streamResult);
        out.close();

        String result = new String(out.toByteArray());
        System.out.println(result);
    }
    public void read(File file){
        def extractor = ExtractorFactory.createExtractor(file)
        println extractor.getText()
    }
}
