requires "Math::Int128" => "0";
requires "Math::Int64" => "0";
requires "XSLoader" => "0";
requires "perl" => "5.010000";
requires "strict" => "0";
requires "warnings" => "0";

on 'build' => sub {
  requires "Module::Build" => "0.28";
};

on 'configure' => sub {
  requires "Module::Build" => "0.28";
};

on 'develop' => sub {
  requires "Devel::PPPort" => "3.23";
};
