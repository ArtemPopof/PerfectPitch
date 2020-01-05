project('com.github.ArtemPopof.PerfectPitch', 'vala', 'c')

i18n = import('i18n')

conf = configuration_data()
conf.set_quoted('GETTEXT_PACKAGE', meson.project_name())
configure_file(output: 'config.h', configuration: conf)
config_h_dir = include_directories('.')

c_args = [
  '-include', 'config.h'
]

add_global_arguments('-DGETTEXT_PACKAGE="@0@"'.format (meson.project_name()), language:'c')
add_project_arguments('-DI_KNOW_THE_PACKAGEKIT_GLIB2_API_IS_SUBJECT_TO_CHANGE', language : 'c')

executable(
    meson.project_name(),
    'src/Application.vala',
    dependencies: [
        dependency('granite'),
        dependency('gtk+-3.0'),
    ],
    install: true
)
