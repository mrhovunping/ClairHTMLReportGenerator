
<xsl:stylesheet version="1.0"  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <xsl:output method="html" version="4.0"
              encoding="UTF-8" indent="yes"/>

  <xsl:template match="@* | node()">


    <xsl:variable name="vulnerability" select="/ScanReport/vulnerabilities/Vulnerability" />
    <xsl:variable name="countVulnerability" select="count($vulnerability)" />

    <xsl:variable name="defcon1" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Defcon1']" />
    <xsl:variable name="countDefcon1" select="count($defcon1)" />

    <xsl:variable name="critical" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Critical']" />
    <xsl:variable name="countCritical" select="count($critical)" />

    <xsl:variable name="high" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'High']" />
    <xsl:variable name="countHigh" select="count($high)" />

    <xsl:variable name="medium" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Medium']" />
    <xsl:variable name="countMedium" select="count($medium)" />

    <xsl:variable name="low" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Low']" />
    <xsl:variable name="countLow" select="count($low)" />

    <xsl:variable name="negligible" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Negligible']" />
    <xsl:variable name="countNegligible" select="count($negligible)" />

    <xsl:variable name="unknown" select="/ScanReport/vulnerabilities/Vulnerability[severity = 'Unknown']" />
    <xsl:variable name="countUnknown" select="count($unknown)" />

    <html lang="en">

      <head>
        <title>Clair Analysis report : <xsl:value-of select="/ScanReport/image"/></title>

        <link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,600italic,400italic,300italic,300' rel='stylesheet' type='text/css'/>
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.6.1/css/font-awesome.min.css"/>
            <style>
              body {
              font-family: 'Open Sans', sans-serif;
              margin: 0;
              padding: 0;
              background: ghostwhite;
              padding-bottom: 2em;
              }
              /* Typography */

              .lead {
              font-size: 1.4em;
              }
              /* global layout */

              .container {
              padding: 0 0;
              }

              .clearfix:after {
              content: "";
              display: block;
              clear: both;
              }

              .row {
              margin: 0 -20px;
              }

              .row:after {
              display: block;
              clear: both;
              }

              [class*="col-"] {
              padding: 0 20px;
              float: left;
              box-sizing: border-box;
              }

              .col-6 {
              width: 50%;
              }

              .panel {
              /* padding: 1em; */
              border-radius: 4px;
              background: white;
              box-shadow: 0px 1px 2px #e2e2e2;
              }

              .panel h2 {
              margin-top: 0;
              padding-bottom: .2em;
              border-bottom: solid 1px gainsboro;
              }

              .panel:last-child {
              margin-bottom: 0;
              }
              /* Header */

              .app-header {
              background: #2196F3;
              color: white;
              margin: 0 0px 0px 0px;
              padding: 16px 20px;
              box-shadow: 0 -2px 16px #263238;
              position: relative;
              }

              .app-header h1 {
              margin: 0;
              font-weight: lighter;
              text-transform: uppercase;
              }

              .app-intro {
              padding: 20px;
              text-align: center;
              color: #263238;
              background: rgba(255, 255, 255, .8);
              border-bottom: solid 1px #ECEFF1;
              }

              .app-intro h2 {
              font-size: 2em;
              font-weight: lighter;
              }

              .summary {
              line-height: .6em;
              }
              /* report */

              .report {
              margin-top: 20px;
              }

              .graph {
              margin: 0 auto;
              max-width: 960px;
              margin-top: 30px;
              }
              /* Style of the graph */

              .graph .node {
              position: relative;
              display: inline-block;
              height: 24px;
              width: 24px;
              margin: 2px;
              }

              .graph .node .dot {
              position: relative;
              height: 24px;
              width: 24px;
              border-radius: 24px;
              float: left;
              background: gray;
              /* box-shadow: 0 1px 2px rgba(0, 0, 0, .2);
              border: solid 1px rgba(255, 255, 255, .2); */
              }

              .graph .node.Defcon1 .dot {
              background: black;
              }

              .graph .node.Critical .dot {
              background: #e81e1e;
              }

              .graph .node.High .dot {
              background: #E91E63;
              }

              .graph .node.Medium .dot {
              background: #FFA726;
              }

              .graph .node.Low .dot {
              background: #8BC34A;
              }

              .graph .node.Negligible .dot {
              background: #37474F;
              }

              .graph .node.Unknown .dot {
              background: #37474F;
              }

              .graph .node .popup {
              display: none;
              width: 300px;
              position: absolute;
              bottom: 100%;
              margin-bottom: 20px;
              margin-left: -150px;
              left: 2px;
              background: white;
              box-shadow: 0px 1px 2px rgba(0, 0, 0, .2);
              padding: 10px;
              border-radius: 4px;
              /* border: solid 1px #e2e2e2; */
              text-shadow: 0 0 0 transparent;
              }

              .graph .node .popup:after {
              content: '';
              position: absolute;
              top: 100%;
              left: 50%;
              margin-left: -10px;
              display: block;
              width: 0;
              height: 0;
              border-width: 10px 10px 0 10px;
              border-color: white transparent transparent transparent;
              border-style: solid;
              }

              .graph .node .popup:before {
              content: '';
              position: absolute;
              top: 100%;
              left: 50%;
              margin-left: -10px;
              display: block;
              width: 0;
              height: 0;
              border-width: 11px 11px 0 10px;
              border-color: rgba(0, 0, 0, .2) transparent transparent transparent;
              border-style: solid;
              }

              .graph .node .popup > div {
              overflow: hidden;
              text-overflow: ellipsis;
              }

              .graph .node:hover .dot {
              opacity: .8;
              }

              .graph .node:hover .popup {
              display: block;
              max-height: 180px;
              color: dimgray;
              }
              /* bars */

              .bar-bg {
              display: inline-block;
              width: 240px;
              height: 6px;
              position: relative;
              }

              .bar-bar {
              display: block;
              position: absolute;
              top: 0;
              bottom: 0;
              left: 0;
              background: #E91E63;
              border-radius: 2px;
              }

              .bar-bar.Defcon1 {
              background: black;
              }

              .bar-bar.Critical {
              background: #e81e1e;
              }

              .bar-bar.High {
              background: #E91E63;
              }

              .bar-bar.Medium {
              background: #FFA726;
              }

              .bar-bar.Low {
              background: #8BC34A;
              }

              .bar-bar.Negligible {
              background: #37474F;
              }

              .bar-bar.Unknown {
              background: #37474F;
              }
              /* vulnerabilities */

              .report {
              margin: 18px auto;
              max-width: 960px;
              }

              .report .vulnerabilities,
              .report .features > ul {
              margin: 0;
              padding: 0;
              }

              .report .features > ul {
              list-style: none;
              }

              .feature {
              border-bottom: solid 1px #ECEFF1;
              }

              .feature:last-child {
              border-color: #CFD8DC;
              }

              .feature__title {
              padding: 1em;
              }

              .vulnerabilities {
              padding-left: 2.6em !important;
              }

              .vulnerability {
              padding-bottom: .8em;
              padding-right: 2.2em;
              }

              .vulnerabilities .Defcon1 .name {
              color: black;
              }

              .vulnerabilities .Critical .name {
              color: #e81e1e;
              }

              .vulnerabilities .High .name {
              color: #E91E63;
              }

              .vulnerabilities .Medium .name {
              color: #FFA726;
              }

              .vulnerabilities .Low .name {
              color: #8BC34A;
              }

              .vulnerabilities .Negligible .name {
              color: #37474F;
              }

              .vulnerabilities .Unknown .name {
              color: #37474F;
              }
              /* layers */

              .layer .layer__title {
              cursor: pointer;
              padding: 1em;
              border-bottom: solid 1px #CFD8DC;
              color: #37474F;
              margin: 0;
              }

              .layer .layer__title:hover {
              background: #ECEFF1;
              }

              .layer.closed .features {
              display: none;
              }

              .summary-text {
              display: flex;
              max-width: 940px;
              margin: 0 auto;
              margin-bottom: 1em;
              margin-top: 3em;
              }

              .summary-text .node {
              text-align: center;
              flex: 1;
              }

              .summary-text .node:before {
              content: '';
              display: inline-block;
              height: 10px;
              width: 10px;
              border-radius: 50%;
              background: #2196F3;
              margin-right: 10px;
              }

              .summary-text .node.Defcon1:before {
              background: black;
              }

              .summary-text .node.Critical:before {
              background: #e81e1e;
              }

              .summary-text .node.High:before {
              background: #E91E63;
              }

              .summary-text .node.Medium:before {
              background: #FFA726;
              }

              .summary-text .node.Low:before {
              background: #8BC34A;
              }

              .summary-text .node.Negligible:before {
              background: #37474F;
              }

              .summary-text .node.Unknown:before {
              background: #37474F;
              }

              .relative-graph {
              display: flex;
              max-width: 940px;
              margin: 0 auto;
              background: #2196F3;
              flex-direction: row-reverse;
              border-radius: 3px;
              overflow: hidden;
              }

              .relative-graph .node {
              text-align: center;
              height: 8px;
              background: #2196F3;
              }

              .relative-graph .node.Defcon1 {
              background: black;
              }

              .relative-graph .node.Critical {
              background: #e81e1e;
              }

              .relative-graph .node.High {
              background: #E91E63;
              }

              .relative-graph .node.Medium {
              background: #FFA726;
              }

              .relative-graph .node.Low {
              background: #8BC34A;
              }

              .relative-graph .node.Negligible {
              background: #37474F;
              }

              .relative-graph .node.Unknown {
              background: #37474F;
              }
            </style>
          </head>

      <body>
        <div class="container">
          <header class="app-header">
            <h1>Clair Analysis report</h1>
          </header>

          <div class="app-intro clearfix">
            <h2>
              Image:  <xsl:value-of select="/ScanReport/image"/>
            </h2>
            <section class="summary">
              <div>
                <p>
                  <span class="lead">
                    <strong>Total : <xsl:value-of select="$countVulnerability" /> vulnerabilities</strong>
                  </span>
                </p>

                <div class="summary-text">

                  <xsl:if test=" $countUnknown != 0">
                    <div class="node Unknown">
                      Unknown : <strong>
                        <xsl:value-of select="$countUnknown" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countDefcon1 != 0">
                    <div class="node Defcon1">
                      Defcon1 : <strong>
                        <xsl:value-of select="$countDefcon1" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countNegligible != 0">
                    <div class="node Negligible">
                      Negligible : <strong>
                        <xsl:value-of select="$countNegligible" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countLow != 0">
                    <div class="node Low">
                      Low : <strong>
                        <xsl:value-of select="$countLow" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countMedium != 0">
                    <div class="node Medium">
                      Medium : <strong>
                        <xsl:value-of select="$countMedium" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countHigh != 0">
                    <div class="node High">
                      High : <strong>
                        <xsl:value-of select="$countHigh" />
                      </strong>
                    </div>
                  </xsl:if>

                  <xsl:if test=" $countCritical != 0">
                  <div class="node Critical">
                    Critical : <strong>
                      <xsl:value-of select="$countCritical" />
                    </strong>
                  </div>
                  </xsl:if>

                </div>

                <div class="relative-graph">
                  <xsl:if test=" $countDefcon1 != 0">
                  <div class="node Defcon1" style="width: {($countDefcon1) div ($countVulnerability)*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countCritical != 0">
                  <div class="node Critical" style="width: {$countCritical div   $countVulnerability*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countHigh != 0">
                  <div class="node High" style="width: {$countHigh div $countVulnerability*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countMedium != 0">
                  <div class="node Medium" style="width: {$countMedium div $countVulnerability*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countLow != 0">
                  <div class="node Low" style="width: {$countLow  div $countVulnerability*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countNegligible != 0">
                  <div class="node Negligible" style="width: {$countNegligible div $countVulnerability*100}%"></div>
                  </xsl:if>
                  <xsl:if test=" $countUnknown != 0">
                  <div class="node Unknown" style="width: {$countUnknown div $countVulnerability*100}%"></div>
                  </xsl:if>
                </div>
              </div>
            </section>

            <div class="graph">
              <xsl:for-each select="/ScanReport/vulnerabilities/Vulnerability">
                <a class="node {severity}" href="#{vulnerability}">
                  <div class="dot"></div>
                  <div class="popup">
                    <div>
                      <strong>
                        <xsl:value-of select="featurename"/>
                      </strong>
                    </div>
                    <div>
                      <xsl:value-of select="severity"/>
                    </div>
                    <div>
                      <xsl:value-of select="featureversion"/>
                    </div>
                  </div>
                </a>
              </xsl:for-each>
            </div>
          </div>

          <section class="report">
            <div>
              <div class="panel">
                <div class="layers">
                  <div class="layer">

                    <h3 class="layer__title" >Details of vulnerabilities</h3>

                    <xsl:if test=" $countVulnerability != 0">
                    <div class="features">
                      <ul>
                        <li class="feature">

                              <xsl:for-each select="/ScanReport/vulnerabilities/Vulnerability">
                                <div id="{vulnerability}" class="feature__title">
                                  <strong><xsl:value-of select="featurename"/></strong>&#160;<span><xsl:value-of select="featureversion"/></span> - <span class="fa fa-exclamation-triangle" aria-hidden="true"></span>
                                </div>
                                <ul class="vulnerabilities">
                                  <li class="vulnerability {severity}">
                                    <a class="vulnerability__title" name="{vulnerability}"></a>
                                    <strong class="name"><xsl:value-of select="vulnerability"/></strong>
                                    <div>"<xsl:value-of select="description"/>"</div>
                                    <div>
                                      <a href="{link}" target="blank">Link</a> - Fixed by: <xsl:value-of select="fixedby"/>
                                    </div>
                                  </li>
                                </ul>
                              </xsl:for-each>
                        </li>
                      </ul>
                    </div>
                    </xsl:if>

                    <xsl:if test=" $countVulnerability = 0">
                      <div class="features">
                        <ul>
                          <li class="feature">
                            No vulnerability found !!!!
                          </li>
                        </ul>
                      </div>
                    </xsl:if>
                  </div>
                </div>
              </div>
              <br />
            </div>
          </section>
        </div>

        <script>
          (function() {
          const togglers = document.querySelectorAll('[data-toggle-layer]');
          console.log(togglers);

          for (var i = togglers.length - 1; i >= 0; i--) {
          togglers[i].onclick = function(e) {
          e.target.parentNode.classList.toggle('closed');
          };
          }
          })();
        </script>
      </body>

    </html>


  </xsl:template>
</xsl:stylesheet>
