<?xml version="1.0"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" version="1.0"/>
<xsl:param name="db_name" />
<xsl:param name="rom_path" />
<xsl:template match="/">{
  "version": "1.2",
  <xsl:call-template name="core" />
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

<xsl:template name="core">
	<xsl:variable name= "core_file">
		<xsl:choose>
			<xsl:when test = "contains($rom_path,'/roms/amiga')">amiberry_launcher_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/atari7800')">prosystem_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/atarilynx')">handy_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/dreamcast')">flycast_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/fds')">nestopia_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/gamegear')">genesis_plus_gx_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/gb')">gambatte_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/gba')">mgba_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/gbc')">gambatte_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/mastersystem')">genesis_plus_gx_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/megadrive')">genesis_plus_gx_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/n64')">mupen64plus_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/neogeo')">fbneo_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/nes')">nestopia_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/ngp')">mednafen_ngp_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/pce-cd')">mednafen_pce_fast_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/pcengine')">mednafen_pce_fast_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/psx')">pcsx_rearmed_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/satellaview')">snes9x2010_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/sega32x')">picodrive_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/segacd')">genesis_plus_gx_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/snes')">snes9x2010_libretro.so</xsl:when>
			<xsl:when test = "contains($rom_path,'/roms/wonderswancolor')">mednafen_wswan_libretro.so</xsl:when>
			<xsl:otherwise></xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name= "core_path">
		<xsl:choose>
			<xsl:when test = "$core_file = ''"></xsl:when>
			<xsl:otherwise>/opt/retropie/libretrocores/</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
    "default_core_path": "<xsl:value-of select="concat($core_path,$core_file)"/>",
    "default_core_name": "<xsl:value-of select="$core_file"/>",
</xsl:template>

</xsl:stylesheet> 
