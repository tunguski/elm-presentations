module Css exposing (..)

import String exposing (concat)


slidesCss cssConfig = """
@import "//bootswatch.com/flatly/bootstrap.min.css";

.menu-links {
  position: absolute;
  right: 0px;
  bottom: 20px;
}

.nav.menu-links > li > a {
  padding: 5px 20px;
  text-align: right;
}

.google-trends iframe {
  zoom: 120%;
  background-color: white;
}

.slide {
  max-width: 640px;
}

.article > .slide {
  margin: auto;
  margin-top: 120px;
}

h1 {
  padding-top: 120px;
}

h2 {
  margin-bottom: 40px;
}

.main-title {
  font-size: 400%;
  
}

p {
  color: #666;
}

.li-description {
  color: #999;
}


ol > li, ul > li {
  margin-bottom: 10px;
}

ol, ul {
  margin-top: 20px;
}

ol.no-span > li,
ul.no-span > li {
  margin-bottom: initial;
}

ol.no-span,
ul.no-span {
  margin-top: initial;
}


span.important {
  text-decoration: underline;
  color: black;
}

li:empty {
  display: none;
}

li.ul-subtitle {
  color: black;
  list-style-type: none;
  font-size: 120%;
}

table.no-break-first td:first-child {
  white-space: nowrap;
}

table.bigger-first td:first-child {
  font-size: 120%;
}

code {
  color: #111;
  border: 1px solid #c7254e;
  background-color: initial;
}

.full-image {
  max-width: 640px;
  width: 100%;
}


.img-responsive {
  margin-bottom: 10px;
  box-shadow: 0 0 8px 2px #999;
}

.logo-ic {
  transform: scale(0.5, 0.5);
  overflow: hidden;
  max-height: 64px;
  position: absolute;
  left: -35px;
  bottom: 10px;
}

.logo-ic img {
  margin-top: -65px;
}

.vertical-middle,
table.table td.vertical-middle {
  vertical-align: middle;
}
"""


generateCss config = concat [ """
#side-menu {
   height: """, toString (config.windowSize.height - 51), """px; 
}

#page-wrapper {
   min-height: """, toString (config.windowSize.height - 51), """px; 
}

.browsehappy {
  margin: 0.2em 0;
  background: #ccc;
  color: #000;
  padding: 0.2em 0;
}

a:hover,
.anchor:hover {
  cursor: pointer;
}

tr.anchor:hover * {
  background-color: #eee;
}

nav.navbar-default {
  margin-bottom: 0;
}

.navbar-default a.navbar-brand:hover {
  color: #00417d;
}


.highlighted { 
  background: yellow; 
}

.fa.arrow {
  -webkit-transition: 0.5s ease all;
          transition: 0.5s ease all;
  -webkit-transform: rotate(90deg);
      -ms-transform: rotate(90deg);
          transform: rotate(90deg);
}

.fa.arrow.down {
  -webkit-transform: rotate(-90deg);
      -ms-transform: rotate(-90deg);
          transform: rotate(-90deg);
}

form.golden-record-search button i.fa-spinner {
  margin-left: 10px;
}

.customer-table {
  background-color: white;
}

.customer-table * {
  white-space: nowrap;
}

.customer-table {
  margin-bottom: 0;
}

.customer-table + .customer-table > tbody > tr:FIRST-CHILD > th {
  border-top: 1px solid #aaa;
}

.panel-body.server-logs {
  overflow-x: hidden;
}

.message-row:first-child {
  margin-top: 20px;
}

.golden-records-search {
  border: 1px solid #aaa;
}


.loading-report {
  margin-top: 100px;
}

.margin-bottom,
ul.nav-pills {
  margin-bottom: 10px;
}

.nav > li > a, .nav > li > b {
  padding: 6px 12px;
}

.nav > li > b {
  color: #777;
  display: block;
}

.nav > li > a {
  padding-left: 20px;
  padding-right: 20px;
}

@media(min-width:768px) {
  .sidebar-small .nav > li > a {
    padding-left: 15px;
    padding-right: 15px;
  }
}

.sidebar ul li a.active {
  border-right: 3px solid;
}

.nav > li.last-in-group {
  border-bottom-color: #f8f8f8;
}

@media(min-width:768px) {
  .sidebar-small .nav > li {
    text-align: center;
  }
  
  .sidebar-small .nav > li.last-in-group {
    border-bottom-color: #e7e7e7;
  }
  
  .side-menu-toggler {
    border-top: 1px solid #ddd;
    border-bottom-width: 0;
  }
}

.nav > li.menu-header {
  padding-top: 12px;
}

.nav-pills > li > a {
  border-radius: 0;
}


@media (max-width: 992px) {
  .nav-pills > li {
    float: none;
  }
  
  .nav-pills > li + li {
    margin-top: 2px;
    margin-left: 0;
  }
}


h1, .h1, h2, .h2, h3, .h3 {
  color: #00417d;
}

.centered {
  position: fixed;
  top: 50%;
  left: 50%;
  /* bring your own prefixes */
  -webkit-transform: translate(-50%, -50%);
      -ms-transform: translate(-50%, -50%);
          transform: translate(-50%, -50%);
}

.centered-title {
  position: fixed;
  left: 50%;
  /* bring your own prefixes */
  -webkit-transform: translate(-50%, 0%);
      -ms-transform: translate(-50%, 0%);
          transform: translate(-50%, 0%);
}

.sidebar-nav {
  position: relative;
}

.sidebar-nav .menu-collapse {
  position: absolute;
  left: 0;
  right: 0;
  bottom: 0;
  background-color: #eee;
}

.sidebar-nav ul li span {
  padding-left: 5px;
}

@media(min-width:768px) {
  .sidebar-small .sidebar {
    width: 50px;
  }
  
  .sidebar-small .menu-header,
  .sidebar-small a span {
    display: none;
  }
  
  .sidebar-small #page-wrapper {
    margin: 0 0 0 50px;
  }
}

.header {
  color: #333;
}

.title {
  font-weight: bold;
  text-align: right;
}


/**************************************************************************************************
 Panel zawierający list-group (usuwamy zbędne marginesy i obramowania)
 **************************************************************************************************/

.panel-body-list-group {
  padding: 0;
}

.panel-body-list-group .list-group {
  margin-bottom: 0;
}

.panel-body-list-group .list-group-item {
  border-width: 0;
  border-top-width: 1px;
}

.panel-body-list-group .list-group-item:first-child {
  border-width: 0;
}


/**************************************************************************************************
 Modify startbootstrap-sb-admin-2
 **************************************************************************************************/

.navbar-brand {
  font-weight: bold;
  color: #00417d;
}
""" ]
