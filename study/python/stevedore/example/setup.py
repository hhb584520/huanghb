from setuptools import setup, find_packages

setup(
    name='hstevedore-examples',
    version='1.0',

    description='Demonstration package for stevedore',

    author='Doug Hellmann',
    author_email='doug@doughellmann.com',

    url='http://opendev.org/openstack/stevedore',

    classifiers=['Development Status :: 3 - Alpha',
                 'License :: OSI Approved :: Apache Software License',
                 'Programming Language :: Python',
                 'Programming Language :: Python :: 2',
                 'Programming Language :: Python :: 2.7',
                 'Programming Language :: Python :: 3',
                 'Programming Language :: Python :: 3.5',
                 'Intended Audience :: Developers',
                 'Environment :: Console',
                 ],

    platforms=['Any'],

    scripts=[],

    provides=['hstevedore.examples',
              ],

    packages=find_packages(),
    install_requires=['stevedore'],
    include_package_data=True,

    entry_points={
        'hstevedore.example.formatter': [
            'simple = hstevedore_example.hsimple:Simple',
            'plain = hstevedore_example.hsimple:Simple',
        ],
    },

    zip_safe=False,
)
