var foundFiles = 0;
var foundLines = 0;

function $(el) {
  return document.getElementById(el);
}

function f() {
  foundFiles += 1;
  $('filecount').innerText = ('' + foundFiles).concat(' file').concat( (foundFiles == 1 ) ? '' : 's' );
}

function l() {
  foundLines += 1;
  $('linecount').innerText = ('' + foundLines).concat(' line').concat( (foundLines == 1 ) ? '' : 's' );
}

function searchStarted() {
  $('teaser').style.display = 'none';
}

function searchCompleted() {
  $('teaser').style.display = 'block';
  new FoldSupport();
  // $('fold').style.display = 'block';
  // $('fold-toggle').addEventListener('change', function() {
  //   $('fold-lbl').innerHTML = "Unfold results";
  // }, false);
}

function FoldSupport() {
  this.container = $('fold');
  this.checkbox  = $('fold-toggle');
  this.label     = $('fold-lbl');
  this.results   = document.querySelectorAll('.file');
  console.log(this.results.length); 
  this.toggle();
  this.setupObservers();
}

FoldSupport.prototype = {
  toggle: function() {
    if(this.container.style.display == 'none')
      this.container.style.display = 'block';
    else
      this.container.style.display = 'none';
  },
  
  setupObservers: function() {
    this.setupMainFolding();
    this.setupTableFolding();
  },
  
  
  setupMainFolding: function() {
    var self = this;
    this.checkbox.addEventListener('change', function() {
      var lbl = self.label.innerHTML, display;
      if(lbl.indexOf('Unfold') == -1) {
        display = 'none';
        self.label.innerHTML = 'Unfold Results';
      } else {
        display = 'block';
        self.label.innerHTML = 'Fold results';
      }
    
      for (var i=0; i < self.results.length; i++) {
        var file = self.results[i];
        var matches = file.getElementsByTagName('tbody')[0];
        matches.style.display = display;
      };
    }, false);
  },
  
  setupTableFolding: function() {
    var self = this;
    for (var i=0; i < this.results.length; i++) {
      var file = this.results[i];
      var hdr = file.getElementsByTagName('thead')[0];
      hdr.addEventListener('click', function() {
        var node = this.parentNode; 
        if(node.tagName.toLowerCase() == 'table') {
          self.toggleMatchesIn(node);
        }
      }, false);
    }
  },
  
  toggleMatchesIn: function(table) {
    var matches = table.querySelector('.matches');
    if(matches.style.display == 'none')
      matches.style.display = 'block';
    else
      matches.style.display = 'none';
  }
}