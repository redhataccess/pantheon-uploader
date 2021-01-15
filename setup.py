from setuptools import setup, find_packages

entry_points = {
    'console_scripts': [
        'pantheon1 = uploader.pantheon:main'
    ]
}

if __name__ == "__main__":
    setup(
        name='uploader',
        version='0.2',
        packages=find_packages(),
        url='',
        license='',
        author='Red Hat, Inc.',
        author_email='',
        description='Uploads modular documents to Pantheon',
        install_requires=[
            'argparse',
            'requests',
            'PyYAML',
            'redis'
        ],
        entry_points=entry_points
    )
