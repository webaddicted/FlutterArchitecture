class PersonImgRespo {
    List<Profiles> profiles;
    int id;

    PersonImgRespo({this.profiles, this.id});

    PersonImgRespo.fromJson(Map<String, dynamic> json) {
        if (json['profiles'] != null) {
            profiles = new List<Profiles>();
            json['profiles'].forEach((v) {
                profiles.add(new Profiles.fromJson(v));
            });
        }
        id = json['id'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        if (this.profiles != null) {
            data['profiles'] = this.profiles.map((v) => v.toJson()).toList();
        }
        data['id'] = this.id;
        return data;
    }
}

class Profiles {
    Null iso6391;
    int width;
    int height;
    int voteCount;
    double voteAverage;
    String filePath;
    double aspectRatio;

    Profiles(
        {this.iso6391,
            this.width,
            this.height,
            this.voteCount,
            this.voteAverage,
            this.filePath,
            this.aspectRatio});

    Profiles.fromJson(Map<String, dynamic> json) {
        iso6391 = json['iso_639_1'];
        width = json['width'];
        height = json['height'];
        voteCount = json['vote_count'];
        voteAverage = json['vote_average'];
        filePath = json['file_path'];
        aspectRatio = json['aspect_ratio'];
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['iso_639_1'] = this.iso6391;
        data['width'] = this.width;
        data['height'] = this.height;
        data['vote_count'] = this.voteCount;
        data['vote_average'] = this.voteAverage;
        data['file_path'] = this.filePath;
        data['aspect_ratio'] = this.aspectRatio;
        return data;
    }
}