import 'package:html/parser.dart' as html_parser;
import 'package:html/dom.dart' as html_dom;

String removeHtmlTags(String htmlString) {
  final document = html_parser.parse(htmlString);
  return _parseTextFromDocument(document.body);
}

String _parseTextFromDocument(html_dom.Node? node) {
  if (node == null) {
    return '';
  }
  if (node is html_dom.Element) {
    return node.nodes.map(_parseTextFromDocument).join('');
  }
  if (node is html_dom.Text) {
    return node.data;
  }
  return '';
}
