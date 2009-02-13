class AckInProject::SearchDialog
  include AckInProject::Environment
  AckInProject::Environment.ghetto_include %w(web_preview), binding
  
  def show(&block)
    raise ArgumentError, 'show_search_dialog requires a block' if block.nil?

    verify_project_directory or return
    
    command = %Q{#{TM_DIALOG} -cm -p #{e_sh params.to_plist} -d #{e_sh defaults.to_plist} #{e_sh nib_file('AckInProjectSearch.nib')}}
    plist = OSX::PropertyList::load(%x{#{command}})
    if plist['result']
      block.call(plist)
    end
  end
  
  def defaults
    %w(
      ackMatchWholeWords ackIgnoreCase ackLiteralMatch 
      ackShowContext ackFollowSymlinks ackLoadAckRC
    ).inject({}) do |hsh,v|
      hsh[v] = false
      hsh
    end
  end
  
  def params
    {
      'ackExpression' => AckInProject.pbfind,
      'ackHistory' => AckInProject.search_history,
      'ackFileTypes' => filetypes,
      'ackFileType' => 'All'
    }
  end
  
  def verify_project_directory
    return true if project_directory
    
    puts <<-HTML
    <html><body>
      <h1>Can't determine project directory (TM_PROJECT_DIR)</h1>
    </body></html>
    HTML
  end
  
  def filetypes
    # I'm sure there's a better way to do this. But I'm not familiar with it.
    [
      {'filetype'=>'All'},
      {'filetype'=>'actionscript'},
      {'filetype'=>'asm'},
      {'filetype'=>'batch'},
      {'filetype'=>'binary'},
      {'filetype'=>'cc'},
      {'filetype'=>'cfmx'},
      {'filetype'=>'cpp'},
      {'filetype'=>'csharp'},
      {'filetype'=>'css'},
      {'filetype'=>'elisp'},
      {'filetype'=>'erlang'},
      {'filetype'=>'fortran'},
      {'filetype'=>'haskell'},
      {'filetype'=>'hh'},
      {'filetype'=>'html'},
      {'filetype'=>'java'},
      {'filetype'=>'js'},
      {'filetype'=>'jsp'},
      {'filetype'=>'lisp'},
      {'filetype'=>'lua'},
      {'filetype'=>'make'},
      {'filetype'=>'mason'},
      {'filetype'=>'objc'},
      {'filetype'=>'objcpp'},
      {'filetype'=>'ocaml'},
      {'filetype'=>'parrot'},
      {'filetype'=>'perl'},
      {'filetype'=>'php'},
      {'filetype'=>'plone'},
      {'filetype'=>'python'},
      {'filetype'=>'rake'},
      {'filetype'=>'ruby'},
      {'filetype'=>'scheme'},
      {'filetype'=>'shell'},
      {'filetype'=>'skipped'},
      {'filetype'=>'smalltalk'},
      {'filetype'=>'sql'},
      {'filetype'=>'tcl'},
      {'filetype'=>'tex'},
      {'filetype'=>'text'},
      {'filetype'=>'tt'},
      {'filetype'=>'vb'},
      {'filetype'=>'vim'},
      {'filetype'=>'xml'},
      {'filetype'=>'yaml'}
    ]
  end
end


