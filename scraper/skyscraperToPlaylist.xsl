<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" version="1.0"/>
<xsl:param name="db_name" />
<xsl:param name="rom_path" />
<xsl:template match="/">{
  "version": "1.2",
  "default_core_path": "",
  "default_core_name": "",
  "label_display_mode": 0,
  "right_thumbnail_mode": 0,
  "left_thumbnail_mode": 0,
  "items": [<xsl:apply-templates select="gameList/game"/>
   ]
}
</xsl:template>


<xsl:template match="game">
    {
      "path": "<xsl:value-of select="concat($rom_path,substring(path,2))"/>",
      "label": "<xsl:value-of select="substring-before(substring-after(image, './media/screenshots/'),'.png')"/>",
      "core_path": "DETECT",
      "core_name": "DETECT",
      "crc32": "0|crc",
      "db_name": "<xsl:value-of select="$db_name"/>"
    }<xsl:if test="position() != last()">,</xsl:if>

</xsl:template>

</xsl:stylesheet> 
