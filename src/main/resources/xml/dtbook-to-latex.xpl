<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:px="http://www.daisy.org/ns/pipeline/xproc"
    xmlns:sbs="http://www.sbs.ch/pipeline"
    exclude-inline-prefixes="#all"
    type="sbs:dtbook-to-latex" name="dtbook-to-latex" version="1.0">
    
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <h1 px:role="name">DTBook to LaTeX</h1>
        <p px:role="desc">Transforms a DTBook (DAISY 3 XML) document into LaTeX.</p>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Bert Frees</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
            <dt>E-mail:</dt>
            <dd><a px:role="contact" href="mailto:bert.frees@sbs.ch">bert.frees@sbs.ch</a></dd>
        </dl>
        <p px:role="acknowledgement">The code was taken from the se_tpb_dtbook2latex transformer in DAISY Pipeline 1.</p>
        <p>Original authors:</p>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Linus Ericson</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.mtm.se">MTM</dd>
        </dl>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Christian Egli</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
        </dl>
        <dl px:role="author">
            <dt>Name:</dt>
            <dd px:role="name">Bert Frees</dd>
            <dt>Organization:</dt>
            <dd px:role="organization" href="http://www.sbs.ch">SBS</dd>
        </dl>
    </p:documentation>
    
    <p:input port="source" primary="true" px:name="source" px:media-type="application/x-dtbook+xml">
        <p:documentation>
            <h2 px:role="name">source</h2>
            <p px:role="desc">Input DTBook.</p>
        </p:documentation>
    </p:input>
    
    <p:option name="output-dir" required="true" px:output="result" px:type="anyDirURI">
        <p:documentation>
            <h2 px:role="name">output-dir</h2>
            <p px:role="desc">Directory for storing result files.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="fontsize" required="false" px:type="string" select="'17pt'">
      <p:documentation>
        <h2 px:role="name">fontsize</h2>
        <p px:role="desc">Font size for the generated LaTeX. See also the documentation of the extsizes package (http://www.ctan.org/tex-archive/macros/latex/contrib/extsizes). Possible values are '12pt', '14pt', '17pt', '20pt' or '25pt'. Default is '17pt'.</p>
        <pre><code class="example">17pt</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="font" required="false" px:type="string" select="'Tiresias LPfont'">
      <p:documentation>
        <h2 px:role="name">font</h2>
        <p px:role="desc">Font for the generated LaTeX. This can basically be any installed TrueType or OpenType font for example 'Tiresias LPfont', 'LMRoman10 Regular', 'LMSans10 Regular' or many others. Default is 'Tiresias LPfont' as this fornt was designed especially for visually imraired.</p>
        <pre><code class="example">Tiresias LPfont</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="backupFont" required="false" px:type="string" select="'Arial Unicode MS'">
      <p:documentation>
        <h2 px:role="name">backupFont</h2>
        <p px:role="desc">Optional secondary font to be used for specific Unicode ranges specified in backupUnicodeRanges. The ucharclasses package (http://ctan.org/tex-archive/macros/xetex/latex/ucharclasses) must be installed for this feature.</p>
        <pre><code class="example">Arial Unicode MS</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="backupUnicodeRanges" required="false" px:type="string" select="''">
      <p:documentation>
        <h2 px:role="name">backupUnicodeRanges</h2>
        <p px:role="desc">Comma-separated list of Unicode ranges (in camel case notation) for which the backup font must be applied.</p>
        <pre><code class="example">Arabic,Hebrew,Cyrillic,GreekAndCoptic</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="defaultLanguage" required="false" px:type="string" select="'english'">
      <p:documentation>
        <h2 px:role="name">defaultLanguage</h2>
        <p px:role="desc">Language for the babel package if no language is specified in a xml:lang tag. For all valid values check the babel documentation (http://www.ctan.org/get/macros/latex/required/babel/babel.pdf)</p>
        <pre><code class="example">english</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="stocksize" required="false" px:type="string" select="'a4paper'">
      <p:documentation>
        <h2 px:role="name">stocksize</h2>
        <p px:role="desc">Stock size for the generated LaTeX</p>
        <pre><code class="example">a4paper</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="alignment" required="false" px:type="string" select="'justified'">
      <p:documentation>
        <h2 px:role="name">alignment</h2>
        <p px:role="desc">Alignment for standard text. Possible values are 'justified' or 'left'. Default is 'justified'.</p>
        <pre><code class="example">justified</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="pageStyle" required="false" px:type="string" select="'plain'">
      <p:documentation>
        <h2 px:role="name">pageStyle</h2>
        <p px:role="desc">Page style for the generated LaTeX. Possible values are 'plain', 'withPageNums' or 'scientific'. Default is 'plain'.</p>
        <pre><code class="example">plain</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="line_spacing" required="false" px:type="string" select="'singlespacing'">
      <p:documentation>
        <h2 px:role="name">line_spacing</h2>
        <p px:role="desc">Line spacing in the generated LaTeX. Possible values are 'singlespacing', 'onehalfspacing' or 'doublespacing'. Default is 'singlespacing'.</p>
        <pre><code class="example">singlespacing</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="paperwidth" required="false" px:type="string" select="'200mm'">
      <p:documentation>
        <h2 px:role="name">paperwidth</h2>
        <p px:role="desc">Specific width of the paper</p>
        <pre><code class="example">200mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="paperheight" required="false" px:type="string" select="'250mm'">
      <p:documentation>
        <h2 px:role="name">paperheight</h2>
        <p px:role="desc">Specific height of the paper</p>
        <pre><code class="example">250mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="left_margin" required="false" px:type="string" select="'28mm'">
      <p:documentation>
        <h2 px:role="name">left_margin</h2>
        <p px:role="desc">Specific inner margin of the paper</p>
        <pre><code class="example">28mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="right_margin" required="false" px:type="string" select="'20mm'">
      <p:documentation>
        <h2 px:role="name">right_margin</h2>
        <p px:role="desc">Specific outer margin of the paper</p>
        <pre><code class="example">20mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="top_margin" required="false" px:type="string" select="'20mm'">
      <p:documentation>
        <h2 px:role="name">top_margin</h2>
        <p px:role="desc">Specific top margin of the page</p>
        <pre><code class="example">20mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="bottom_margin" required="false" px:type="string" select="'20mm'">
      <p:documentation>
        <h2 px:role="name">bottom_margin</h2>
        <p px:role="desc">Specific bottom margin of the page</p>
        <pre><code class="example">20mm</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="replace_em_with_quote" required="false" px:type="boolean" select="'false'">
      <p:documentation>
        <h2 px:role="name">replace_em_with_quote</h2>
        <p px:role="desc">Replace em with quoted text as emphasis might be hard to read</p>
        <pre><code class="example">false</code></pre>
      </p:documentation>
    </p:option>
    
    <p:option name="endnotes" required="false" px:type="string" select="'none'">
      <p:documentation>
        <h2 px:role="name">endnotes</h2>
        <p px:role="desc">Put notes at the end of the chapter or at the end of the document instead of putting them on the same page like footnotes. Possible values are 'none', 'document' and 'chapter'</p>
        <pre><code class="example">none</code></pre>
      </p:documentation>
    </p:option>
    
    <p:import href="dtbook-to-latex.convert.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/dtbook-utils/library.xpl"/>
    <p:import href="http://www.daisy.org/pipeline/modules/fileset-utils/library.xpl"/>
    
    <!-- =========== -->
    <!-- LOAD DTBOOK -->
    <!-- =========== -->
    
    <px:dtbook-load name="dtbook">
        <p:input port="source">
            <p:pipe step="dtbook-to-latex" port="source"/>
        </p:input>
    </px:dtbook-load>
    
    <!-- ======================= -->
    <!-- CONVERT DTBOOK TO LATEX -->
    <!-- ======================= -->
    
    <sbs:dtbook-to-latex.convert name="latex">
        <p:input port="fileset.in">
            <p:pipe step="dtbook" port="fileset.out"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe step="dtbook" port="in-memory.out"/>
        </p:input>
        <p:with-option name="output-dir" select="$output-dir">
            <p:empty/>
        </p:with-option>
        <p:with-option name="fontsize" select="$fontsize"/>
        <p:with-option name="font" select="$font"/>
        <p:with-option name="backupFont" select="$backupFont"/>
        <p:with-option name="backupUnicodeRanges" select="$backupUnicodeRanges"/>
        <p:with-option name="defaultLanguage" select="$defaultLanguage"/>
        <p:with-option name="stocksize" select="$stocksize"/>
        <p:with-option name="alignment" select="$alignment"/>
        <p:with-option name="pageStyle" select="$pageStyle"/>
        <p:with-option name="line_spacing" select="$line_spacing"/>
        <p:with-option name="paperwidth" select="$paperwidth"/>
        <p:with-option name="paperheight" select="$paperheight"/>
        <p:with-option name="left_margin" select="$left_margin"/>
        <p:with-option name="right_margin" select="$right_margin"/>
        <p:with-option name="top_margin" select="$top_margin"/>
        <p:with-option name="bottom_margin" select="$bottom_margin"/>
        <p:with-option name="replace_em_with_quote" select="$replace_em_with_quote"/>
        <p:with-option name="endnotes" select="$endnotes"/>
    </sbs:dtbook-to-latex.convert>
    
    <!-- =================== -->
    <!-- STORE LATEX FILESET -->
    <!-- =================== -->
    
    <px:fileset-store>
        <p:input port="fileset.in">
            <p:pipe step="latex" port="fileset.out"/>
        </p:input>
        <p:input port="in-memory.in">
            <p:pipe step="latex" port="in-memory.out"/>
        </p:input>
    </px:fileset-store>
    
</p:declare-step>
