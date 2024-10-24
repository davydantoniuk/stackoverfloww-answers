import xml.etree.ElementTree as ET

tree = ET.parse('file.xml')
root = tree.getroot()

# Find all headers by their tag name
headers = root.findall('.//header1')  # Use './/' to find all occurrences

for header in headers[1:]:
    root.remove(header)
