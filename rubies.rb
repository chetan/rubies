#!/usr/bin/env ruby

require 'haml'
require 'date'

rubies = []

rubies << {
  :name    => "MRI 1.8",
  :desc    => "Matz's Ruby Interpreter",
  :license => "Ruby or BSD",
  :url     => "http://www.ruby-lang.org/",
  :version => "1.8.7-p371",
  :date    => DateTime.parse("Fri Oct 12 12:25:15 2012").to_time,
  :compat  => "-",
  :stable  => true,
  :ext     => true,
  :mac     => true,
  :win     => true,
  :linux   => true,
}

rubies << {
  :name    => "MRI 1.9",
  :desc    => "Matz's Ruby Interpreter",
  :license => "Ruby or BSD",
  :url     => "http://www.ruby-lang.org/",
  :version => "1.9.3-p327",
  :date    => DateTime.parse("09 Nov 2012").to_time,
  :compat  => "-",
  :stable  => true,
  :ext     => true,
  :mac     => true,
  :win     => true,
  :linux   => true,
}


rubies << {
  :name    => "JRuby",
  :desc    => "Ruby on the JVM",
  :license => "CPL, GPLv2, LGPLv2.1",
  :url     => "http://www.jruby.org/",
  :version => "1.7.1",
  :date    => DateTime.parse("December 03 2012").to_time,
  :compat  => "1.8.7, 1.9.3p327",
  :stable  => true,
  :ext     => false,
  :fork    => false,
  :mac     => true,
  :win     => true,
  :linux   => true,
}

rubies << {
  :name    => "Rubinius",
  :desc    => "Rubinius is an implementation of the Ruby programming language",
  :license => "BSD",
  :url     => "http://rubini.us/",
  :version => "1.2.4",
  :date    => DateTime.parse("Jul 05, 2011").to_time,
  :compat  => "1.8.7",
  :stable  => true,
  :ext     => true,
  :fork    => true,
  :mac     => true,
  :win     => false,
  :linux   => true,
}

rubies << {
  :name    => "IronRuby",
  :desc    => "Ruby for .NET",
  :license => "Apache v2.0",
  :url     => "http://www.ironruby.net/",
  :version => "1.1.3",
  :date    => DateTime.parse("March 13, 2011").to_time,
  :compat  => "1.9.2",
  :stable  => true,
  :ext     => false,
  :fork    => false,
  :mac     => false,
  :win     => true,
  :linux   => false,
  :notes   => "May run on mac/linux via <a href='http://mono-project.com/'>Mono</a>",
}


rubies << {
  :name    => "MagLev",
  :desc    => "Ruby on the GemStone/S VM",
  :license => "MIT, GPL",
  :url     => "http://maglev.github.com/",
  :version => "1.0.0",
  :date    => DateTime.parse("October 31, 2011").to_time,
  :compat  => "1.8.7",
  :stable  => true,
  :ext     => true,
  :fork    => true,
  :mac     => true,
  :win     => false,
  :linux   => true,
  :notes   => "",
}

rubies << {
  :name    => "MacRuby",
  :desc    => "Ruby for the Objective-C Runtime",
  :license => "Ruby",
  :url     => "http://www.macruby.org/",
  :version => "0.12",
  :date    => DateTime.parse("June 11, 2012").to_time,
  :compat  => "1.8.7",
  :stable  => true,
  :ext     => true,
  :fork    => true,
  :mac     => true,
  :win     => false,
  :linux   => false,
  :notes   => "",
}

rubies << {
  :name    => "Ruby Enterprise Edition",
  :desc    => "'Enterprise' fork of MRI",
  :license => "Ruby, GPLv2",
  :url     => "http://www.rubyenterpriseedition.com/",
  :version => "1.8.7-2012-02",
  :date    => DateTime.parse("Feb 19, 2012").to_time,
  :compat  => "1.8.7",
  :stable  => true,
  :ext     => true,
  :fork    => true,
  :mac     => true,
  :win     => false,
  :linux   => true,
  :notes   => "",
}

module Haml::Helpers
  def check(v)
    v ? "<span class='true'>✓</span>" : "<span class='false'>✗</span>"
  end
end

template = <<-EOF
!!! XML
!!! 5
%html
  %head
    %META{ "http-equiv" => "Content-Type", "content" => "text/html; charset=UTF-8" }
    %link{ :href => "bootstrap.min.css", :media=>"screen", :rel=>"stylesheet", :type=>"text/css" }
    %script{ :type => "text/javascript", :src => "https://cdnjs.cloudflare.com/ajax/libs/jquery/1.8.3/jquery.min.js" }
    :css
      th      { white-space: nowrap; }
      .nowrap { white-space: nowrap; }
      .false  { color: #C91A1A; }
      .true   { color: #2EB322; }
    :javascript
      $(function() {
        var DAY = 86400;
        $("td.age").each(function(i, td) {
          var sec = $(td).attr("elapsed");
          var days = Math.floor(sec/DAY);
          $(td).text(days + "d");
        });
      });
    %title Rubies
  %body

    %div.container-fluid
      %div.row-fluid
        %div.span12

          %h1 Rubies

          %table.table.table-striped
            %thead
              %tr
                %th Name
                %th License
                %th Version
                %th Release Date
                %th Age
                %th Compatibility
                %th Stable?
                %th C Extensions?
                %th Process.fork?
                %th Mac
                %th Windows
                %th Linux
                %th Notes
            %tbody
              - rubies.each do |r|
                %tr.ruby
                  %td.nowrap
                    %a{ :href => r[:url], :title => r[:desc] }= r[:name]
                  %td= r[:license]
                  %td= r[:version]
                  %td= r[:date].strftime("%Y-%m-%d")
                  %td.age{ :elapsed => (Time.new.to_i-r[:date].to_i) }
                  %td= r[:compat]
                  %td= check(r[:stable])
                  %td= check(r[:ext])
                  %td= check(r[:fork])
                  %td= check(r[:mac])
                  %td= check(r[:win])
                  %td= check(r[:linux])
                  %td= r[:notes]

EOF
puts Haml::Engine.new(template).render(Object.new, :rubies => rubies)
